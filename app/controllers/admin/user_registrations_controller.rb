class Admin::UserRegistrationsController < Devise::RegistrationsController
  private
  def after_inactive_sign_up_path_for(resource)
    confirmation_next_step_path
  end

  def sign_up_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :current_password)
  end
end
