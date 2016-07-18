class Admin::BaseController < ApplicationController
  layout 'sidenav'

  before_action :authenticate_user!

  check_authorization unless: :devise_controller?

  before_action do
    if current_user && current_user.has_role?(:superadmin)
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
