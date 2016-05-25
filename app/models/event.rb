class Event < ApplicationRecord
  serialize :schedule, IceCube::Schedule
end
