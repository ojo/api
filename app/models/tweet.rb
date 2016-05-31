class Tweet < ApplicationRecord
  belongs_to :managed_twitter_account
  validates_presence_of :managed_twitter_account
  validates_uniqueness_of :twitter_id

  # we use posted_at (instead of the DB's created_at field) because it isn't
  # relevant when we created the tweet record locally. what matters is when the
  # tweet was originally posted/published.
  def posted_at
    @posted_at ||= Time.parse(JSON.load(self.data)['created_at'])
  end

  def url
    "https://twitter.com/statuses/#{self.twitter_id}"
  end
end
