class BroadcastLikesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SoundChat::LikesChannel.broadcast_to 'likes'
  end
end
