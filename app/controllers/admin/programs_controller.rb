class Admin::ProgramsController < ApplicationController
  def destroy
    Program.destroy(params[:id])
    redirect_to admin_schedule_list_path
  end
end
