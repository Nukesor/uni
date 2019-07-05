package twitter;

import logic.MovieService;
import twitter4j.Status;

public class MovieTweetHandler extends TweetListener {

	private MovieService ms;

	public MovieTweetHandler(MovieService ms, int limit, String[] keywords) {
		super(limit, keywords);
		this.ms = ms;
	}

	@Override
	public void onTweet(Status status) {
		String text = status.getText().toLowerCase();
		boolean matched = false;
		for(String[] block: blocks) {
			for (String keyword : block) {
				// Check, which keyword the Tweet matches
				if (text.contains(keyword.toLowerCase())) {
					ms.saveTweet(keyword, status);
					matched = true;
				}
			}
		}
		if (!matched) {
			//System.err.println("No match for tweet @" + status.getUser().getName() + ": " + status.getText());
		}
	}

}