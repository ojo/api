class BroadcastLikesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActionCable.server.broadcast 'likes'
  end
end
