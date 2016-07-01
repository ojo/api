module Admin::ProgramsHelper
  include RecurringSelectHelper::FormHelper

  def program_time_range_pretty p
    s = p.schedule.start_time.strftime("%l").strip
    sampm = p.schedule.start_time.strftime("%P") == 'am' ? 'a' : 'p'
    e = p.schedule.end_time.strftime("%l").strip
    eampm = p.schedule.end_time.strftime("%P") == 'am' ? 'a' : 'p'
    "#{s}#{sampm}-#{e}#{eampm}"
  end
end
