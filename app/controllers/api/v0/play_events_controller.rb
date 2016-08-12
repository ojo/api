class Api::V0::PlayEventsController < Api::V0::BaseController
  before_action :restrict_access, only: [:create]

  def create
    s = Station.find_by(tag: params['station_tag'])
    if s == nil
      msg = "cannot find station with tag: #{params['station_tag']}"
      return render json: { error: msg }, status: :bad_request
    end

    m = params['play_event']

    unless PlayEvent::MEDIA_TYPES.include? m['media_type']
      msg = "Media Type (#{m['media_type']}) is not supported"
      return render json: { error: msg }, status: :bad_request
    end

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
      return render json: { error: msg, play_event: pe, input: params }, status: 500
    end

    if pe.image == nil and pe.media_type == 'Song'
      FetchPlayEventImageJob.perform_later pe
    end

    # the job worries about validation
    BroadcastNowPlayingJob.perform_later s

    render json: {}, status: :ok
  end
end
