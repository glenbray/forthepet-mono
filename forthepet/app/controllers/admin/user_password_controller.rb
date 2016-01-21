class Admin::UserPasswordController < Admin::AdminController
  add_crumb 'Users / Users', '/admin/users'

  def index
    @user = User.find(params[:user_id])
    add_crumb 'Edit User', "/admin/users/#{params[:user_id]}/edit"
    add_crumb 'Change Password'
  end

  def create
    @user = User.find(params[:user_id])

    if user_params['password'] == user_params['password_confirmation'] && user_params['password'] != '' && user_params['password_confirmation'] != ''
      if @user.update(user_params.merge(reset_password_token: 'temp'))
        flash[:success] = 'Users password has been updated.'
      else
        flash[:danger] = 'Users password was not updated. An error occured.'
      end
    else
      flash[:danger] = 'Users password was not updated. Password did not meet requirements.'
    end
    redirect_to admin_user_password_index_path(@user)
  end

  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
