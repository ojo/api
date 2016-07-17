class BroadcastLikesJob < ApplicationJob
  def perform(*args)
    ActionCable.server.broadcast 'likes'
  end
end
