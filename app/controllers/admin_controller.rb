class AdminController < ApplicationController
  layout 'bootstrap'

  def index
    @stations = Station.all
  end
end
