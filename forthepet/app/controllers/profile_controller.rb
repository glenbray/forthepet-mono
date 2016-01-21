class ProfileController < ApplicationController
  def index
    @user = current_user
    # render json: @user
  end

  def update
    id = current_user.id
    if current_user.update(update_user)
      sign_in User.find(id)
      flash[:success] = 'You have successfully updated your profile'
      redirect_to profile_index_path
    else
      # flash[:danger] = 'Unable to update your profile and error occured!'
      render :index
    end
  end

  private

  def update_user
    params.require(:user).permit(:first_name, :last_name, :mobile, :phone, :password)
  end
end
