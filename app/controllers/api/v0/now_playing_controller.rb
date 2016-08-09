class Api::V0::NowPlayingController < Api::V0::BaseController

  def create_serato_dj
    # TODO
  end

  def create_nexgen
    return head :unauthorized if ENV.fetch('METADATA_UPLOAD_API_TOKEN') != params['Token']

    # TODO image_name = params['ImageHash']

    m = params['Metadata']

    s = Station.find_by(tag: params['Station'])
    if s == nil
      msg = "cannot find station with tag: #{params['Station']}"
      render json: { errors: msg }, status: :bad_request
      return
    end

    pe = PlayEvent.new
    pe.title = m['Title']
    pe.artist = m['Artist']
    pe.album = m['AlbumTitle']
    pe.type = m['Type'] # Song, Spot, etc.
    pe.length_in_secs = m['LengthInSecs']
    pe.nexgen_id = m['Number']
    pe.station = s
    # TODO m['StartedAt']
    # NB: ignore m['ImagePath']

    if not pe.save
      msg = "couldn't save play event"
      render json: { errors: msg, play_event: pe, input: params }, status: 500
      return
    end

    head 200
  end

  def upload_images
    head 200
  end
end
