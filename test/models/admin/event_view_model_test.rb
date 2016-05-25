require "test_helper"

class Admin::EventViewModelTest < MiniTest::Test

  def setup
    @params = {
               "start_date"=>"05/25/2016", 
               "end_time(1i)"=>"2016", 
               "end_time(2i)"=>"5", 
               "end_time(3i)"=>"25", 
               "end_time(4i)"=>"11", 
               "end_time(5i)"=>"55",
               "start_time(1i)"=>"2016", 
               "start_time(2i)"=>"5", 
               "start_time(3i)"=>"27", 
               "start_time(4i)"=>"05", 
               "start_time(5i)"=>"15",
    }
  end
  
  def event_view_model
    @event_view_model ||= Admin::EventViewModel.new @params
  end

  def test_valid
    v = event_view_model.valid?
    assert v
  end

  def test_convert_to_ice_cube
    s = event_view_model.to_ice_cube
    assert s.occurs_on?(Date.parse('2016-05-25'))
  end

  def test_respects_h_and_m_from_start_time
    h = @params["start_time(4i)"]
    m = @params["start_time(5i)"]
    assert_equal h.to_i, event_view_model.to_ice_cube.start_time.hour.to_i
    assert_equal m.to_i, event_view_model.to_ice_cube.start_time.min.to_i
  end

  def test_respects_h_and_m_from_end_time
    h = @params["end_time(4i)"]
    m = @params["end_time(5i)"]
    assert_equal event_view_model.to_ice_cube.end_time.hour.to_i, h.to_i
    assert_equal event_view_model.to_ice_cube.end_time.min.to_i, m.to_i
  end

  def test_instiantiate_without_mass_assignment
    Admin::EventViewModel.new
  end

end
