class Admin::ProgramsController < Admin::BaseController
  def index
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
    redirect_to admin_programs_calendar_path
  end

  def edit
    @program = Program.find_by_id params[:id]
    @view_model = Admin::ProgramViewModel.from_program @program
    raise ArgumentError.new @view_model.errors.messages unless @view_model.valid?
  end

  def update
    @view_model = Admin::ProgramViewModel.new event_view_model_params
    if not @view_model.valid?
      flash[:notice] = @view_model.errors.messages
      render :edit
      return
    end
    existing = Program.find_by_id!(params[:id])
    @view_model.to_program(existing).save!
  end

  def destroy
    Program.destroy(params[:id])
    redirect_to admin_programs_path
  end

  def calendar
    @programs = Program.all.sort_by { |p| p.schedule.start_time }
    @start_date = params[:start_date] ? Date.strptime(params[:start_date]) : Date.today
  end

  private
  def event_view_model_params
    params.require(:program).permit(*Admin::ProgramViewModel::PUBLIC_ACCESSORS)
  end
end
