package web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logic.MovieService;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.bson.Document;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.NCSARequestLog;
import org.eclipse.jetty.server.Request;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.handler.ContextHandler;
import org.eclipse.jetty.server.handler.DefaultHandler;
import org.eclipse.jetty.server.handler.HandlerList;
import org.eclipse.jetty.server.handler.RequestLogHandler;
import org.eclipse.jetty.server.handler.ResourceHandler;
import org.eclipse.jetty.util.resource.Resource;
import org.eclipse.jetty.util.ssl.SslContextFactory;

import twitter.MovieTweetHandler;
import twitter.TweetStream;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.client.FindIterable;
import com.mongodb.client.gridfs.model.GridFSFile;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.util.JSON;

public class RestServer {
	
	/**
	 * A very simple Jetty-based REST server that serves static content and
	 * handles REST API requests.
	 */
	public static void main(String[] args) throws Exception {
		Server server = new Server(5900);
		final MovieService ms = new MovieService();

		// Serve static files
		ResourceHandler resource_handler = new ResourceHandler();
		resource_handler.setDirectoriesListed(true);
		resource_handler.setWelcomeFiles(new String[] { "map.html" });
		resource_handler.setBaseResource(Resource.newClassPathResource("/web"));

		// Define Resources and Actions
		ContextHandler tweetedMovies = handle("/movie_tweets", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				System.out.println("Update movies tweets on map");
				int limit = 100;
				String limitParam = request.getParameter("limit");
				if (limitParam != null)
					limit = Integer.parseInt(limitParam);
				return ms.getTaggedTweets().limit(limit);
			}
		});

		ContextHandler searchSuggestions = handle("/suggestions", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				String query = request.getParameter("query");
				return MovieService.extract(ms.suggest(query, 8), "title");
			}
		});
		
		ContextHandler comment = handle("/comment", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				if (request.getMethod().equals("POST")) {
					String id = request.getParameter("id");
					String comment = request.getParameter("comment");
					System.out.println(id + ", " +comment);
					ms.saveMovieComment(id, comment);
				}
				return new BasicDBObject("ok", true);
			}
		});

		ContextHandler stream = handle("/stream", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				if (request.getMethod().equals("POST")) {
					final Integer limit = Integer.valueOf(request.getParameter("limit"));
					String onlyTagged = request.getParameter("tagged");
					final boolean tagged;
					if(onlyTagged != null)
						tagged = Boolean.parseBoolean(onlyTagged);
					else
						tagged = false;
					String keywords = request.getParameter("keywords");
					String[] titles = null;
					if (keywords == null) {
						String year = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
						ArrayList<Document> docs = loadPopularMovies(year);
						
						titles = new String[docs.size()];
						ArrayList<String> titlesList = (ArrayList<String>) docs.stream().map(d -> d.getString("title")).collect(Collectors.toList());
						titlesList.toArray(titles);
					} else {
						titles = (keywords).split(",");
					}
					final String[] titlesFinal = titles;
					// Run asynchronously in order not to get blocked.
					Thread thread = new Thread() {
						public void run() {
							TweetStream ts = new TweetStream();
							
							
							
							MovieTweetHandler handler = new MovieTweetHandler(ms, limit, titlesFinal);
							handler.setIgnoreUntagged(tagged);
							ts.listenToStream(handler);
						}
					};
					thread.start();
				}
				return new BasicDBObject("ok", true);
			}
		});

		ContextHandler movieSearch = handle("/movies", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				String title = request.getParameter("title");
				//Prefix / Title Search
				if (title != null) {
					Boolean exact = Boolean.parseBoolean(request.getParameter("exact"));
					if (exact) {
						return ms.findMovieByTitle(title);
					} else {
						FindIterable<Document> cursor = ms.searchByPrefix(title, 1);
						//Extract a single object
						if(cursor.iterator().hasNext())
							return cursor.iterator().next();
						else
							return null;
					}
				}
				//handle different kinds of queries
				else {
					String query = request.getParameter("query");
					String type = request.getParameter("type");
					if (type == null)
						type = "";
					Integer limit = Integer.valueOf(request.getParameter("limit"));
					if (type.equals("rating-greater")) {
						if(query.equals("")) query = "0.0";
						return ms.getBestMovies(1000, Double.parseDouble(query), limit);
					}
					else if (type.equals("genre")) {
						if(query.equals("")) query = "Action";
						return ms.getByGenre(query, limit);
					}
					else if (type.equals("geo"))
						return ms.getByTweetsKeywordRegex(query, limit);
					else if (type.equals("tweeted"))
						return ms.getTweetedMovies(limit);
					else
						return ms.searchByPrefix(query, limit);
				}
			}
		});

		ContextHandler tweetSearch = handle("/tweets", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				String query = request.getParameter("query");
				System.out.println(query);
				String type = request.getParameter("type");
				if (type == null)
					type = "";
				Integer limit = Integer.valueOf(request.getParameter("limit"));
				limit = limit > 2000 ? 2000 : limit;
				if (type.equals("geo"))
					return ms.getGeotaggedTweets(limit);
				else if (type.equals("fts")) {
					return ms.searchTweets(query);
				}
				else if (type.equals("near")) {
					String[] parts = query.split(",");
					return ms.getTweetsNear(Double.parseDouble(parts[0]), Double.parseDouble(parts[1]),
							Integer.parseInt(parts[2]));
				} else
					return ms.getNewestTweets(limit);
			}
		});
		
		ContextHandler newMovies = handle("/new_movies", new MongoHandler() {
			@Override
			public Object getData(HttpServletRequest request) {
				if (request.getMethod().equals("POST")) {
						
					final String year = request.getParameter("year");
					ArrayList<Document> docs = loadPopularMovies(year);
					
						for (Document d : docs) {
							
							String id = String.valueOf(d.get("id"));					
							ArrayList<Integer> genre_ids = (ArrayList<Integer>) d.get("genre_ids");
							ArrayList<String> genres = new ArrayList<String>();
							for (Integer genre : genre_ids) {
								if(GENRES.containsKey(genre)) {
									genres.add(GENRES.get(genre));
								}
							}
							String plot = d.getString("overview");
							Double rating = Double.valueOf(String.valueOf(d.get("vote_average")));	
							String date = "ISODATE("+ d.getString("release_date").replaceAll(" ", "")  +"T23:00:00Z)";
							String runtime = "";
							String title = d.getString("title");
							Integer votes = new Random().nextInt(200);
							
							Document movie = new Document("_id", id).
							append("actors", "").
							append("genre", genres).
							append("movie", true).
							append("plot", plot).
							append("rating", rating).
							append("releases", new Document("country", "USA").
									append("date", date)).
							append("runtime", "").append("title", title).append("votes", votes).append("year", year);
											
							ms.upsertMovie(movie);						
						}
				}
				return new Document("ok", true);
			}
		});
		
		ContextHandler images = handle("/images", new AbstractHandler() {
			@Override
			public void handle(String target, Request baseRequest, HttpServletRequest request, HttpServletResponse response)
				    throws IOException, ServletException {
				try {
				String name = request.getParameter("name");
				String url = request.getParameter("url");
				if (request.getMethod().equals("GET")) {
					//Serve from Gridfs
					if(url == null) {
						GridFSFile file = ms.getFile(name);
						response.setStatus(HttpServletResponse.SC_OK);
						response.setContentLength((int) file.getLength());
						response.setContentType(file.getMetadata().get("contentType").toString());
						ms.downloadFile(file, response.getOutputStream());
						baseRequest.setHandled(true);
						return;
					}
					//Import from IMDB
					else {
						System.out.println("load from imdb: " + name);
						SslContextFactory sslContextFactory = new SslContextFactory();
						HttpClient client = new HttpClient(sslContextFactory);
						client.start();
						ContentResponse r = client.GET(url);
						byte[] content = r.getContent();
						String contentType = r.getHeaders().get("Content-Type");
						InputStream stream = new ByteArrayInputStream(content);
						ms.saveFile(name, stream, contentType);
					}
				}
				//Upload to GridFS
				else if (request.getMethod().equals("POST")) {
					FileItemFactory factory = new DiskFileItemFactory();
					ServletFileUpload upload = new ServletFileUpload(factory);
					List<FileItem> items = upload.parseRequest(request);
					for(FileItem item : items) {
						System.out.println(item.getName());
						if(!item.isFormField()) {
						    String contentType = item.getContentType();
							ms.saveFile(name, item.getInputStream(), contentType);
						    return;
						}
					}
				}
				response.setContentType("application/json;charset=utf-8");
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().print((new Document("name", name)).toJson());
				baseRequest.setHandled(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

		//Enable Logging
		RequestLogHandler logging = new RequestLogHandler();
		logging.setRequestLog(new NCSARequestLog());
		
		// Register all Resources
		HandlerList handlers = new HandlerList();
		handlers.setHandlers(new Handler[] { logging, tweetedMovies, newMovies, stream, comment, movieSearch, images, searchSuggestions, tweetSearch,
				resource_handler,  new DefaultHandler() });
		server.setHandler(handlers);

		server.start();
		server.join();
	}
	
	private static ArrayList<Document> loadPopularMovies(String year) {
		SslContextFactory sslContextFactory = new SslContextFactory();
		HttpClient client = new HttpClient(sslContextFactory);
		ArrayList<Document> docs = new ArrayList<Document>();
		try {
			client.start();
			ContentResponse r = client.GET("https://api.themoviedb.org/3/discover/movie?primary_release_year="+year+"&sort_by=popularity.desc&api_key=0e5d3cf45c19570f6451afd826cfd801");
			byte[] content = r.getContent();
			String contentType = r.getHeaders().get("Content-Type");
			InputStream stream = new ByteArrayInputStream(content);
			int n = stream.available();
			byte[] bytes = new byte[n];
			stream.read(bytes, 0, n);
			String s = new String(bytes);
			 docs = (ArrayList<Document>) Document.parse(s).get("results");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return docs;
	}
	

	/**
	 * Define a new resource
	 * 
	 * @param path
	 *            URL path of the resource
	 * @param mongoHandler
	 *            the corresponding Handler
	 * @return
	 */
	private static ContextHandler handle(String path, AbstractHandler mongoHandler) {
		ContextHandler context = new ContextHandler();
		context.setContextPath(path);
		context.setResourceBase(".");
		context.setAllowNullPathInfo(true);
		context.setClassLoader(Thread.currentThread().getContextClassLoader());
		context.setHandler(mongoHandler);
		return context;
	}

	/**
	 * An implementation of the Jetty handler. Override the abstract getData()
	 * method and return data that can be parsed as JSON.
	 */
	public abstract static class MongoHandler extends AbstractHandler {

		public void handle(String target, Request baseRequest, HttpServletRequest request, HttpServletResponse response)
				throws IOException, ServletException {
			response.setContentType("application/json;charset=utf-8");
			response.setStatus(HttpServletResponse.SC_OK);
			baseRequest.setHandled(true);
			response.getWriter().print(JSON.serialize(getData(request)));
		}

		abstract public Object getData(HttpServletRequest request);

	}
	
	public static final  Map<Integer, String> GENRES = new HashMap<Integer, String>()
	{
	    {
	        put(28, "Action");
	        put(12, "Adventure");
	        put(16, "Animation");
	        put(35, "Comedy");
	        put(80, "Crime");
	        put(99, "Documentary");
	        put(18, "Drama");
	        put(10751, "Family");
	        put(14, "Fantasy");
	        put(36, "History");
	        put(27, "Horror");
	        put(10402, "Music");
	        put(9648, "Mystery");
	        put(10749, "Romance");
	        put(878, "Science Fiction");
	        put(10770, "TV Movie");
	        put(53, "Thriller");
	        put(10752, "War");
	        put(37, "Western");
	    }
	};

}