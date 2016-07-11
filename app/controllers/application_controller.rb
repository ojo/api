class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO(btc): explore API implications
  protect_from_forgery with: :exception

  def layout_by_resource
    if devise_controller?
      'bootstrap'
    else
      'application'
    end
  end
end
