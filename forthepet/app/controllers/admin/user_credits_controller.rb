class Admin::UserCreditsController < Admin::AdminController
  add_crumb 'Users / Users', '/admin/users'

  def index
    @user = User.find(params[:user_id])
    add_crumb 'Edit User', "/admin/users/#{params[:user_id]}/edit"
    add_crumb 'Credits'
  end
end
