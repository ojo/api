class BroadcastNowPlayingJob < ApplicationJob
  def perform station
    np = station.now_playing
    serializer = Api::V0::NowPlayingSerializer.new(np)
    adapted = ActiveModelSerializers::Adapter::JsonApi.new(serializer)
    $fcm.send_with_notification_key(topic_for_station(station),
                                    data: adapted)
  end

  def topic_for_station s
    "/topics/now-playing-#{s.tag}"
  end
end
