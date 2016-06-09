class Program < ApplicationRecord
  belongs_to :station
  serialize :schedule, IceCube::Schedule

  # TODO validate that there aren't conflicting events for a given station
end
