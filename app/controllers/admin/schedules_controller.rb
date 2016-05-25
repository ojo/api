class Admin::SchedulesController < ApplicationController
  layout "bootstrap"

  def index
  end

  def users
  end

  def schedule
  end

  def list
  end

  def new
    @event = Admin::EventViewModel.new
    @event.start_date = Date.today.strftime('%m/%d/%Y')
  end

  def create
    @m = Admin::EventViewModel.new event_view_model_params
    is_rule = RecurringSelect.is_valid_rule?(@m.recurrences)
    puts @m.recurrences.class, is_rule
    if not @m.valid?
      puts @m.errors.messages
      head 400
      return
    end
    @e = Event.new
    @e.name = @m.name
    @e.schedule = @m.to_ice_cube
    @e.save!
  end

  private
  def event_view_model_params
    params.require(:event).permit(*Admin::EventViewModel::PUBLIC_ACCESSORS)
  end
end
