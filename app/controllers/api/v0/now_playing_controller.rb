class Api::V0::NowPlayingController < Api::V0::BaseController

  def create_serato_dj
    # TODO
  end

  def create_nexgen
    return head :unauthorized if ENV.fetch('METADATA_UPLOAD_API_TOKEN') != params['Token']

    s = Station.find_by(tag: params['Station'])
    if s == nil
      msg = "cannot find station with tag: #{params['Station']}"
      render json: { errors: msg }, status: :bad_request
      return
    end

    m = params['Metadata'] # NB: ignore m['ImagePath']

    pe = PlayEvent.new
    pe.title = m['Title']
    pe.artist = m['Artist']
    pe.album = m['AlbumTitle']
    pe.media_type = m['Type'] # Song, Spot, etc.
    pe.length_in_secs = m['LengthInSecs']
    pe.nexgen_id = m['Number']
    pe.station = s
    pe.image = PlayEventImage.find_by(name: params['ImageName']) # optional
    # TODO m['StartedAt']

    if not pe.save
      msg = "couldn't save play event"
      render json: { errors: msg, play_event: pe, input: params }, status: 500
      return
    end

    if pe.image == nil
      FetchPlayEventImageJob.perform_later pe
    end

    head 200
  end

  def upload_images
    return head :unauthorized if ENV.fetch('METADATA_UPLOAD_API_TOKEN') != params['token']
    image = PlayEventImage.find_or_create_by(name: params['name']) do |i|
      i.file = params['image']
    end
    return head 500 if not image.persisted?
    head 200
  end
end
