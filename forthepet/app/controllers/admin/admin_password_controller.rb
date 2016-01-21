class Admin::AdminPasswordController < Admin::AdminController
  add_crumb 'Admins', '/admin/admins'

  def index
    @admin = Admin.find(params[:admin_id])
    add_crumb 'Edit Admin', "/admin/admins/#{params[:admin_id]}/edit"
    add_crumb 'Change Password'
  end

  # This will also handle updates due to me globbing the two forms into one
  def create
    admin = Admin.find(params[:admin_id])

    if admin_params['password'] == admin_params['password_confirmation'] && admin_params['password'] != '' && admin_params['password_confirmation'] != ''
      if admin.update(admin_params)
        flash[:success] = 'Admins password has been updated.'
        if current_admin.id == admin.id
          sign_in admin, bypass: true # Renew session
        end
      else
        flash[:danger] = 'Admins password was not updated. An error occured.'
      end
    else
      flash[:danger] = 'Admins password was not updated. Password did not meet requirements.'
    end
    redirect_to admin_admin_password_index_path(admin)
  end

  private

  def admin_params
    params.required(:admin).permit(:password, :password_confirmation)
  end
end
