class Admin::UserConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    confirmation_confirmed_path
  end
end
