package twitter;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;

public class TweetStream {

	private TwitterStream ts;

	public TweetStream() {
		ts = createStream();
	}

	public void listenToStream(TweetListener listener) {
		ts.addListener(listener);
		listener.start(ts);
	}
	
	public static Configuration getConfiguration() {
		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setDebugEnabled(true).setOAuthConsumerKey("lpGZqmGCqw03LfvznZIxEw")
				.setOAuthConsumerSecret("FjG8BQ3WYEbejeoZGnZJHUZAYl0A2t4IFNJUacHXJzw")
				.setOAuthAccessToken("1361849587-P7Qgeb76mbOUybIR8YvBpNXrIs6Surco2KM5yN8")
				.setOAuthAccessTokenSecret("tOoUPysaZoa1kej8bVJqd2r4jLhecOLYjlFfBuRes")
				.setJSONStoreEnabled(true)
				.setDebugEnabled(false);
		return cb.build();
	}
	
	public static TwitterStream createStream() {
		return new TwitterStreamFactory(getConfiguration()).getInstance();
	}

}
