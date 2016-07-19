class Admin::RolesController < Admin::BaseController

  def update
    authorize! :manage, Role

    # given params user_id, action, role
    user_id = params[:user_id]
    role_name = params[:role]
    instruction = params[:instruction]

    # validate user
    @user = User.find_by_id(user_id)
    if @user.nil?
      flash[:alert] = 'please select a user'
      redirect_to action: :manage and return
    end

    # validate role_name
    unless Role.role_names.include?(role_name)
      flash[:alert] = 'please select a role'
      redirect_to action: :manage and return
    end
    @role = Role.find_or_create_by(name: role_name)

    # validate instruction/process valid request
    case instruction
    when 'add'
      @role.users.append @user
    when 'remove'
      @role.users.delete @user
    else
      flash[:alert] = 'please select an action'
      redirect_to action: :manage and return
    end

    flash[:notice] = 'success!'
    redirect_to action: :manage and return
  end

  def manage
    authorize! :manage, Role

    @users = User.all.order(email: :asc)
  end
end
