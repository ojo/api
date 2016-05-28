class Station < ApplicationRecord
  has_many :programs

  EventTypes = [:program, :song, :spot]

  def current_program
    active_program = self.programs.to_a.keep_if { |p| 
      p.schedule.is_occurring? Time.now
    }.first
    active_program 
  end
end
