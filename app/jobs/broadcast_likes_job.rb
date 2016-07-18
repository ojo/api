class BroadcastLikesJob < ApplicationJob
  def perform sender_id
    r = Ratelimit.new(self.class.name, redis: $redis, bucket_interval: 1)
    if r.exceeded?('likes', threshold: 2, interval: 1) # 2 per second
      return
    end
    r.add('likes')
    ActionCable.server.broadcast 'likes', { sender: sender_id }
  end
end
