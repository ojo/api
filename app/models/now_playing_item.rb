# wraps a PlayEvent
class NowPlayingItem
  APP_NAME = "OJO"

  attr_accessor :station

  def initialize station
    self.station = station
  end

  def event
    @play_event ||= station.current_play_event # TODO and active
  end

  def program
    @program ||= station.current_program
  end

  def title
    # 1. play event's title if there is an active Song play event
    return event.try(:title) if event.try(:media_type) == 'Song'
    # 2. else program's name if there is an active program
    return program.try(:title) if program != nil
    # 3. else blank
    return ""
  end

  def artist
    # 1. play_event's artist if there is an active Song
    return event.try(:artist) if event.try(:media_type) == 'Song'
    # 2. program's cast if there is an active program
    return program.try(:cast) if program != nil
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

  def media_type
    return event.media_type if event != nil
    return 'Program' if program != nil
    return ''
  end

  # TODO started_at
  # TODO duration
  # TODO ending_at
  # TODO seconds_remaining?
end
