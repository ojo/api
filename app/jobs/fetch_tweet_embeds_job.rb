class FetchTweetEmbedsJob < ApplicationJob
  queue_as :default
  NUM_EMBEDS_PER_ACCOUNT = 10
  NUM_SECONDS_TO_WAIT = 0 # try once. give up immediately.

  def perform(*args)
    ManagedTwitterAccount.with_advisory_lock(self.class.name, NUM_SECONDS_TO_WAIT) do 
      ManagedTwitterAccount.all.each do |a|
        tweets = a.tweets.order(twitter_id: :desc).where(embed: nil).take(NUM_EMBEDS_PER_ACCOUNT)
        tweets.each { |t| fetch_and_save_embed t }
      end
    end
  end

  def fetch_and_save_embed t
    begin
      resp = $twitter.oembed t.url
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
    t.embed = resp.html
    t.save
  end
end
