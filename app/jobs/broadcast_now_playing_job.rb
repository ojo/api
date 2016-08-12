class BroadcastNowPlayingJob < ApplicationJob
  def perform station
    np = station.now_playing
    json = Api::V0::NowPlayingSerializer.new(np).as_json
    $fcm.send_with_notification_key(topic_for_station(station),
                                    data: json)
  end

  def topic_for_station s
    "/topics/now-playing-#{s.tag}"
  end
end
