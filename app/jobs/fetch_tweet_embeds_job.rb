class FetchTweetEmbedsJob < ApplicationJob
  queue_as :default
  NUM_EMBEDS_PER_ACCOUNT = 10

  def perform(*args)
    ManagedTwitterAccount.all.each do |a|
      tweets = a.tweets.order(twitter_id: :desc).take(NUM_EMBEDS_PER_ACCOUNT).keep_if { |x| x.embed == nil }
      tweets.each { |t| fetch_and_save_embed t }
    end
  end

  def fetch_and_save_embed t
    begin
      resp = $twitter.oembed t.url
    rescue Twitter::Error::TooManyRequests 
      return
    end
    t.embed = resp.html
    t.save
  end
end
