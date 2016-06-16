class InstagramPost < ApplicationRecord
  belongs_to :managed_instagram_account

  def posted_at
    secs_since_epoch = JSON.load(self.data)['created_time'].to_i
    Time.at secs_since_epoch
  end
end
