class Admin::UsersController < Admin::AdminController
  add_crumb 'Users', '/admin/users'

  def index
    @q = User.order('id ASC').search(params[:q])
    @users = UserDecorator.decorate_collection(@q.result.page(params[:page]))
  end

  def edit
    @user = User.find(params[:id])
    add_crumb 'Edit User', "/admin/users/#{params[:id]}/edit"
    add_crumb 'Details'
  end

  def update
    user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if user.update(user_params)
      flash[:success] = 'User updated'
    else
      flash[:danger] = 'Unable to update user'
    end

    redirect_to edit_admin_user_path(user)
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = 'Successfully deleted user'
    else
      flash[:danger] = 'Unable to delete user'
    end
    redirect_to admin_users_path
  end

  def logout_and_register
    sign_out current_user
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :mobile, :phone)
  end

  def user_password_params
    params.required(:user).permit(:password, :password_confirmation)
  end
end
