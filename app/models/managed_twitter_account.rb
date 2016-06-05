class ManagedTwitterAccount < ApplicationRecord
  has_many :tweets
  validates_uniqueness_of :username

  # FIXME: class method?
  def latest_tweet_has_embed
    t = self.tweets.order(twitter_id: :desc).first
    t != nil && t.embed != nil
  end
end
