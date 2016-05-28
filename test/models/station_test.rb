require "test_helper"

class StationTest < ActiveSupport::TestCase
  def station
    @station ||= Station.new
  end

  def test_valid
    assert station.valid?
  end
end
