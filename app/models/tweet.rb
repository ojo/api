class Tweet < ApplicationRecord
  belongs_to :managed_twitter_account
  validates_presence_of :managed_twitter_account
  validates_uniqueness_of :twitter_id

  def url
    "https://twitter.com/statuses/#{self.twitter_id}"
  end
end