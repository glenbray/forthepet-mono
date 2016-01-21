class Account::UpdatePasswordController < ApplicationController
  def update
    @redirect_to = account_root_path
    @error = 'Your password was not updated.'
    @user = current_user

    if user_params['password'] == user_params['password_confirmation'] && user_params['password'] != '' && user_params['password_confirmation'] != ''
      if @user.update(user_params)
        sign_in @user, bypass: true
        flash[:success] = 'Your password has been updated.'
        redirect_to @redirect_to
      else
        flash[:danger] = @error
        redirect_to @redirect_to
      end
    else
      flash[:danger] = @error
      redirect_to @redirect_to
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation)
    end
end
