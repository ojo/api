class BroadcastLikesJob < ApplicationJob
  def perform(*args)
    r = Ratelimit.new(self.class.name, redis: $redis)
    if r.exceeded?('likes', threshold: 2, interval: 1) # 2 per second
      return
    end
    r.add('likes')
    ActionCable.server.broadcast 'likes', nil
  end
end
