# wraps PlayEvent, Program, etc.
class NowPlaying
  extend ActiveModel::Naming
  include ActiveModel::Serialization

  APP_NAME = "OJO"

  attr_accessor :station

  def initialize station
    self.station = station
  end

  def event
    @play_event ||= station.current_play_event
  end

  def program
    @program ||= station.current_program
  end

  def id
    station.id
  end

  def title
    # 1. play event's title if there is an active Song play event
    return event.try(:title) if event.try(:media_type) == 'Song'
    # 2. else program's name if there is an active program
    return program.name if program != nil and program.name != nil
    # 3. else blank
    return ""
  end

  def artist
    # 1. play_event's artist if there is an active Song
    return event.try(:artist) if event.try(:media_type) == 'Song'
    # 2. program's cast if there is an active program
    return program.cast if program != nil and program.cast != nil
    # 3. else station name
    return station.name
  end

  def album
    return "#{station.name} - #{APP_NAME}" if title != "" and artist != "" and title != station.name and artist != station.name
    return APP_NAME
  end

  # returns a Paperclip file
  def image
    # 1. TODO Advertisement's image if there is an active Spot play event and has image
    # 2. else Song's image if there is an active song and has image
    return event.try(:image).try(:file) if event.try(:image) != nil
    # 3. TODO else programs's image if there is an active program with image
    # 4. TODO else Station's image if present
    # 5. TODO else App logo
  end

  def image_dominant_color
    return event.image.dominant_color if event != nil and event.image != nil
  end

  def media_type
    return event.media_type if event != nil
    return 'Program' if program != nil
    return ''
  end

  def started_at
    # TODO implement program.started_at
    [event.try(:created_at), program.try(:started_at)].reject(&:nil?).max
  end

  def updated_at
    [event.try(:updated_at), program.try(:updated_at), station.try(:updated_at)].reject(&:nil?).max
  end

  def until # time
    return event.created_at + event.length_in_secs if event != nil
    return program.todays_occurrence.end_time if program != nil
    Time.now
  end

  # TODO duration
  # TODO ending_at
  # TODO seconds_remaining?
end
