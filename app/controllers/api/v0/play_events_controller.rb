class Api::V0::PlayEventsController < Api::V0::BaseController
  before_action :restrict_access, only: [:create]

  def create
    s = Station.find_by(tag: params['station_tag'])
    if s == nil
      msg = "cannot find station with tag: #{params['station_tag']}"
      render json: { errors: msg }, status: :bad_request
      return
    end

    m = params['play_event'] 

    return head :bad_request unless PlayEvent::MEDIA_TYPES.include? ['media_type']

    pe = PlayEvent.new
    pe.title = m['title']
    pe.artist = m['artist']
    pe.album = m['album']
    pe.media_type = m['media_type'] # Song, Spot, etc.
    pe.length_in_secs = m['length_in_secs']
    pe.nexgen_id = m['nexgen_id']

    pe.station = s
    pe.image = PlayEventImage.find_by(name: params['image_name']) # optional

    if not pe.save
      msg = "couldn't save play event"
      render json: { errors: msg, play_event: pe, input: params }, status: 500
      return
    end

    if pe.image == nil and pe.media_type == 'Song'
      FetchPlayEventImageJob.perform_later pe
    end

    head 200
  end
end
