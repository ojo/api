class Program < ApplicationRecord
  belongs_to :station
  serialize :schedule, IceCube::Schedule

  # TODO validate that there aren't conflicting events for a given station

  def todays_occurrence
    bod = Time.now.beginning_of_day
    eod = Time.now.end_of_day
    program.schedule.occurrences_between(bod, eod)[0]
  end
end
