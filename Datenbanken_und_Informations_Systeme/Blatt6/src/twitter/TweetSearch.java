package twitter;

import java.util.LinkedList;
import java.util.List;

import logic.MovieService;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import twitter4j.GeoLocation;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class TweetSearch {

	private Twitter twitter;

	public TweetSearch() {
		twitter = new TwitterFactory(TweetStream.getConfiguration()).getInstance();
	}
	
	public List<Status> search(Query q) {
		return search(q, 1500);
	}
	
	public static Query movieQuery(String... movieNames){
		int endIndex = 10;
		if(endIndex > movieNames.length)
			movieNames = ArrayUtils.subarray(movieNames, 0, endIndex);
		return new Query("\""+StringUtils.join(movieNames, "\" OR \"")+"\"");
	}

	public List<Status> search(Query q, int limit) {
		if(limit < 100)
			q.count(limit);
		else
			q.count(100);
		List<Status> tweets = new LinkedList<Status>();
		QueryResult result;
		try {
			do {
				result = twitter.search(q);
				limit -= result.getCount();
				for(Status status : result.getTweets()) {
					System.out.println(status.getPlace());
				}
				tweets.addAll(result.getTweets());
			} while ((q = result.nextQuery()) != null && limit > 0);
		} catch (TwitterException e) {
			e.printStackTrace();
		}
		return tweets;
	}

	public void searchMovies(MovieService ms, int limit, String... titles) {
		for(String title : titles) {
			Query query = new Query(title);
			query.setResultType(Query.RECENT);
			query.setGeoCode(new GeoLocation(53.598048, 9.931692), 500, "km");
			ms.saveTweets(title, search(query, limit));
		}
	}
}
