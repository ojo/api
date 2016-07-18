class ApplicationController < ActionController::Base
  layout 'application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO(btc): explore API implications
  protect_from_forgery with: :exception

  def health
    # TODO try fetching an object from the DB
    HeartbeatJob.perform_later
    render json: {
      status: 'ok',
      jobs: 'ok'
    }
  end
end
