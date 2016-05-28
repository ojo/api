class Program < ApplicationRecord
  serialize :schedule, IceCube::Schedule

  # TODO validate that there aren't conflicting events for a given station
end
