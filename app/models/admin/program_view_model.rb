class Admin::ProgramViewModel
  include ActiveModel::Model # for easy instantiation with params
  include ActiveModel::Validations # for validations
  include ActiveModel::Validations::Callbacks
  include MultiparameterAttributeAssignment

  PUBLIC_ACCESSORS = [:name, :start_date, :start_time, :end_time, :station_id, :recurrences]

  validates_presence_of :name, :start_date, :start_time, :end_time, :station_id

  validates_each :start_date do |r, attr, val|
    dmy = /\d{2}\/\d{2}\/\d{4}$/
    r.errors.add(attr, 'invalid') unless dmy.match(val)
  end

  before_validation do
    self.recurrences = nil if self.recurrences == 'null'
  end

  validates_each :recurrences do |r, attr, val|
    if val != nil
      is_rule = RecurringSelect.is_valid_rule?(val)
      r.errors.add(attr, 'invalid') unless is_rule
    end
  end

  attr_accessor *PUBLIC_ACCESSORS

  def to_program
    Program.new.tap do |e|
      e.name = self.name
      e.station_id = self.station_id
      e.schedule = self.to_ice_cube
    end
  end

  def to_ice_cube
    sdate = Date.strptime(self.start_date, '%m/%d/%Y')
    edate = sdate

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
      if @recurrences != nil
        r = RecurringSelect.dirty_hash_to_rule(@recurrences)
        s.add_recurrence_rule r
      end
    end
  end

  def class_for_attribute(name)
    Time if %w[start_time end_time].include?(name)
  end
end
