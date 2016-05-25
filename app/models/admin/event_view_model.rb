class Admin::EventViewModel
  include ActiveModel::Model # for easy instantiation with params
  include ActiveModel::Validations # for validations
  include MultiparameterAttributeAssignment

  attr_accessor :start_date, :end_date, :start_time, :end_time

  # def initialize attributes = {}
    # attributes['start_time'] = time_value(attributes, 'start_time')
    # attributes['end_time'] = time_value(attributes, 'end_time')
    # remove_time_values(attributes, 'start_time')
    # remove_time_values(attributes, 'end_time')
    # super
  # end

  def to_ice_cube
    sdate = Date.strptime(self.start_date, '%m/%d/%Y')
    edate = Date.strptime(self.end_date, '%m/%d/%Y')
    stime = Time.new(
      sdate.year, 
      sdate.month, 
      sdate.day, 
      start_time.hour, 
      start_time.min
    )
    etime = Time.new(
      edate.year, 
      edate.month, 
      edate.day, 
      end_time.hour, 
      end_time.min
    )
    IceCube::Schedule.new(stime, end_time: etime).tap do |s|
    end
  end

  validates_each :start_date, :end_date do |r, attr, val|
    dmy = /\d{2}\/\d{2}\/\d{4}$/
    r.errors.add(attr, 'invalid') unless dmy.match(val)
  end

  def class_for_attribute(name)
    Time if %w[start_time end_time].include?(name)
  end
end
