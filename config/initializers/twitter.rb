
$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
  config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
end
