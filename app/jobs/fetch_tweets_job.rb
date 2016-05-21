class FetchTweetsJob < ApplicationJob
  queue_as :default

  TWEETS_PER_REQUEST = 200

  def perform(*args)
    ManagedTwitterAccount.all.each do |a|
      # must save_tweets between fetch calls. save_tweets has the side effect
      # of modifying the database. the state of the database alters the request
      # parameters of subsequent fetches
      save_tweets(fetch_old_tweets(a), a)
      save_tweets(fetch_new_tweets(a), a)
    end
  end

  private
  def fetch_old_tweets account
    tweets = []
    max_id = account.tweets.count > 0 ? account.tweets.minimum('twitter_id') - 1 : nil
    while true do
      opts = {}
      opts[:count] = TWEETS_PER_REQUEST
      if max_id != nil
        opts[:max_id] = max_id
      end # otherwise just fetch the latest
      begin
        resp = $twitter.user_timeline(account.username, opts)
      rescue Twitter::Error::TooManyRequests
        return tweets.flatten # we'll get it later
      end
      if resp.empty?
        break
      end
      max_id = resp.last.id - 1
      tweets << resp
    end
    tweets.flatten
  end

  def fetch_recent_tweets account
    opts = {}
    opts[:count] = TWEETS_PER_REQUEST
    begin
      resp = $twitter.user_timeline(account.username, opts)
    rescue Twitter::Error::TooManyRequests
      return tweets.flatten # we'll get it later
    end
    resp
  end

  def fetch_new_tweets account
    tweets = []
    since_id = account.tweets.count > 0 ? account.tweets.maximum('twitter_id') : nil
    while true do
      opts = {}
      opts[:count] = TWEETS_PER_REQUEST
      opts[:since_id] = since_id if since_id != nil # else just fetch the latest
      begin
        resp = $twitter.user_timeline(account.username, opts)
      rescue Twitter::Error::TooManyRequests
        return tweets.flatten # we'll get it later
      end
      if resp.empty?
        break
      end
      since_id = resp.first.id
      tweets << resp
    end
    tweets.flatten
  end

  def save_tweets tweets, account
    Tweet.transaction do
      tweets.each do |t|
        Tweet.create(twitter_id: t.id, data: t.to_json, managed_twitter_account_id: account.id)
      end
    end
  end
end
