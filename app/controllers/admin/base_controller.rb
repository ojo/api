class Admin::BaseController < ApplicationController
  layout "bootstrap"

  before_action :authenticate_user!

  before_action do
    if current_user && current_user.is_admin?
      Rack::MiniProfiler.authorize_request
    end
  end

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    admin_path
  end
end
