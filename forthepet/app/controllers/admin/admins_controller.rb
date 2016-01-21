class Admin::AdminsController < Admin::AdminController

  add_crumb 'Admins', '/admin/admins'

  def index
    @q = Admin.order('id ASC').search(params[:q])
    @admins = @q.result.page params[:page]
  end

  def edit
    @admin = Admin.find(params[:id])
    add_crumb 'Edit Admin', "/admin/admins/#{params[:id]}/edit"
    add_crumb 'Details'
  end

  def update
    admin = Admin.find(params[:id])

    if params[:admin][:password].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if admin.update(admin_params)
      flash[:success] = 'Admin updated'
    else
      flash[:danger] = 'Unable to update admin'
    end

    redirect_to edit_admin_admin_path(admin)
  end

  def destroy
    admin = Admin.find(params[:id])
    if admin.destroy
      flash[:notice] = 'Successfully deleted admin'
    else
      flash[:danger] = 'Unable to delete admin'
    end
    redirect_to admin_admins_path
  end

  private

  def admin_params
    params.require(:admin).permit(:email)
  end

  def admin_password_params
    params.required(:user).permit(:password, :password_confirmation)
  end
end
