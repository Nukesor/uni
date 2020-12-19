package twitter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.commons.lang3.ArrayUtils;

import twitter4j.FilterQuery;
import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterStream;

public abstract class TweetListener implements StatusListener {
	protected final Lock lock = new ReentrantLock();
	protected final Condition done = lock.newCondition();
	protected int limit;
	protected TwitterStream ts;
	protected HashSet<String> keywordSet;
	protected String[] rawKeywords;
	protected List<String[]> blocks;
	protected int currentBlock;
	protected int currentLimit;
	protected int perBlock;
	protected boolean ignoreUntagged;
	protected TweetStream tweetStream;

	public TweetListener(int limit, String... keywords) {
		int blockSize = 50;
		this.currentBlock = 0;
		this.limit = limit;
		this.keywordSet = new HashSet<String>(keywords.length);
		for (String keyword : keywords) {
			if (!(keyword.length() > 25 || keyword.length() < 4) && !keyword.equals("")) {
				this.keywordSet.add(keyword);
			}
		}
		this.blocks = new ArrayList<String[]>();
		this.rawKeywords = this.keywordSet.toArray(new String[0]);
		for (int i = 0; i - blockSize < this.rawKeywords.length; i += blockSize) {
			String[] sub = ArrayUtils.subarray(this.rawKeywords, i, i + blockSize);
			if(sub.length > 0)
				blocks.add(sub);
		}
		this.perBlock = limit / blocks.size();
		this.currentLimit = this.perBlock;
	}

	public abstract void onTweet(Status status);

	public void start(TwitterStream ts) {
		this.ts = ts;
		filter();
		lock.lock();
		try {
			done.await();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		lock.unlock();
	}

	public void filter() {
		System.err.println("\nWorking on Block: " + ArrayUtils.toString(blocks.get(currentBlock)));
		FilterQuery filterQuery = new FilterQuery(0, null, blocks.get(currentBlock));
		this.ts.filter(filterQuery);
	}

	public void onStatus(Status status) {
		if(ignoreUntagged && status.getGeoLocation() == null)
			return;
		else
			onTweet(status);
		//Check if Limit reached
		if (--currentLimit == 0) {
			if (++currentBlock < blocks.size()) {
				currentLimit = perBlock;
				ts.cleanUp();
				filter();
			} else {
				ts.cleanUp();
				lock.lock();
				done.signal();
				lock.unlock();
			}
		}
	}
	
	public void setIgnoreUntagged(boolean ignore) {
		this.ignoreUntagged = ignore;
	}

	public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
	}

	public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
	}

	public void onException(Exception ex) {
		ex.printStackTrace();
		ts.shutdown();
	}

	public void onScrubGeo(long arg0, long arg1) {
	}

	public void onStallWarning(StallWarning arg0) {
	}
	

	public TweetStream getTweetStream() {
		return tweetStream;
	}

	public void setTweetStream(TweetStream tweetStream) {
		this.tweetStream = tweetStream;
	}


}