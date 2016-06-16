class Admin::SchedulesController < Admin::BaseController 

  def index
    @programs = Program.all.sort_by { |p| p.schedule.start_time }
    @start_date = params[:start_date] ? Date.strptime(params[:start_date]) : Date.today
  end

  def users
  end

  def schedule
  end

  def list
    @programs = Program.order(name: :asc).all
  end

  def new
    @program = Admin::ProgramViewModel.new
    @program.start_date = Date.today.strftime('%m/%d/%Y')
  end

  def create
    @program = Admin::ProgramViewModel.new event_view_model_params
    if not @program.valid?
      flash[:notice] = @program.errors.messages
      render :new
      return
    end
    @program.to_program.save!
    flash[:notice] = "Program saved."
  end

  private
  def event_view_model_params
    params.require(:program).permit(*Admin::ProgramViewModel::PUBLIC_ACCESSORS)
  end
end
