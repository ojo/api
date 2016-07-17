# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SoundChat::LikeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "likes"
  end

  def likes(data)
    BroadcastLikesJob.new.perform_later
  end

  def unsubscribed
    stop_all_streams
  end
end
