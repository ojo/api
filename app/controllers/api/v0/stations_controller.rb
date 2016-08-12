class Api::V0::StationsController < Api::V0::BaseController
  include ::ActionController::Serialization

  def now_playing
    s = Station.find_by(tag: params[:tag])
    return render json: { error: "not found" }, status: :not_found if s == nil
    item = s.now_playing
    render json: item, serializer: Api::V0::NowPlayingSerializer
  end
end
