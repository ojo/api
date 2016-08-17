class Api::V0::NowPlayingSerializer < ActiveModel::Serializer
  type 'now-playing'
  cache key: 'now_playing' # url lookups are expensive
  attributes :id,
    :title,
    :artist,
    :album,
    :media_type,
    :station_tag,
    :started_at,  # UNIX time
    :length_in_secs, # UNIX time
    :artwork_dominant_color,
    :artwork_url_500,
    :artwork_url_300,
    :artwork_url_100

  def title
    object.title
  end

  def artist
    object.artist
  end

  def album
    object.album
  end

  def station_tag
    object.station.tag
  end

  def started_at
    object.started_at.to_i
  end

  def length_in_secs
    object.event.length_in_secs if object.event != nil
  end

  def artwork_dominant_color
    object.image_dominant_color
  end

  def artwork_url_500
    object.try(:image).try(:url, :large)
  end

  def artwork_url_300
    object.try(:image).try(:url, :medium)
  end

  def artwork_url_100
    object.try(:image).try(:url, :thumb)
  end
end
