class Station < ApplicationRecord
  has_many :programs
  has_many :play_events

  validates_presence_of :tag

  EventTypes = [:program, :song, :spot]

  def current_program
    active_program = self.programs.to_a.keep_if { |p|
      p.schedule.is_occurring? Time.now
    }.first
    active_program
  end

  def current_play_event
    candidate = play_events.last

    return nil if candidate == nil

    started = candidate.created_at.to_i
    duration = candidate.length_in_secs
    ending = started + duration
    now = Time.current.to_i

    now < ending ? candidate : nil
  end

  def now_playing
    NowPlaying.new self
  end
end
