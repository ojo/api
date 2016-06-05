class FetchInstagramsJob < ApplicationJob
  queue_as :default

  ITEMS_PER_REQUEST = 20
  NUM_SECONDS_TO_WAIT = 0

  def perform(*args)
    ManagedInstagramAccount.with_advisory_lock(self.class.name, NUM_SECONDS_TO_WAIT) do
      ManagedInstagramAccount.where.not(token: nil).all.each do |a|
        # must save between fetch calls. save has the side effect of modifying
        # the database. the state of the database alters the request parameters
        # of subsequent fetches
        save(fetch(a), a)
      end
    end
  end

  private
  def fetch account
    client = Instagram.client(access_token: account.token)
    # FIXME: invalidate expired tokens?
    
    begin
      resp = client.user_recent_media
    rescue Instagram::RateLimitExceeded => error
      puts error
      sleep error.rate_limit.reset_in + 1
      retry
    end
    resp
  end

  def save posts, account
    InstagramPost.transaction do
      posts.each do |p|
        if InstagramPost.exists?(instagram_id: p.id)
          next
        end
        m = InstagramPost.new(data: p.to_json, managed_instagram_account_id: account.id)
        m.instagram_id = p.id
        m.save
      end
    end
  end
end
