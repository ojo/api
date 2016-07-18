class ApplicationController < ActionController::Base
  layout 'application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO(btc): explore API implications
  protect_from_forgery with: :exception

  def health
    render json: {
      status: 'ok'
    }
  end
end
