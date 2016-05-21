class FetchTweetEmbedsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    t = Tweet.where(embed: nil).order(twitter_id: :desc).first
    fetch_and_save_embed t
  end

  def fetch_and_save_embed t
    url = "https://twitter.com/statuses/#{t.twitter_id}"
    begin
      resp = $twitter.oembed url
    rescue Twitter::Error::TooManyRequests 
      return
    end
    t.embed = resp.html
    t.save
  end
end
