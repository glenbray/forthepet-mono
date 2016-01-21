class Admin::UserAddressesController < Admin::AdminController
  add_crumb 'Users / Users', '/admin/users'

  def index
    @user = User.find(params[:user_id])
    @shipping = @user.billing_id.nil? ? Address.new : @user.shipping
    @billing = @user.shipping_id.nil? ? Address.new : @user.billing
    add_crumb 'Edit User', "/admin/users/#{params[:user_id]}/edit"
    add_crumb 'Addresses'
  end

  # This will also handle updates due to me globbing the two forms into one
  def create
    @user = User.find(params[:user_id])
    @billing = @user.nil? ? Address.new : @user.billing
    @shipping = @user.nil? ? Address.new : @user.shipping

    @billing.first_name = params[:b_first_name]
    @billing.last_name = params[:b_last_name]
    @billing.address1 = params[:b_address1]
    @billing.address2 = params[:b_address2]
    @billing.suburb = params[:b_suburb]
    @billing.state = params[:b_state]
    @billing.postcode = params[:b_postcode]
    @billing.save
    @user.billing_id = @billing.id

    @bis = params[:billing_is_shipping] ? true : false

    @shipping.first_name = @bis ? @billing.first_name : params[:s_first_name]
    @shipping.last_name = @bis ? @billing.last_name : params[:s_last_name]
    @shipping.address1 = @bis ? @billing.address1 : params[:s_address1]
    @shipping.address2 = @bis ? @billing.address2 : params[:s_address2]
    @shipping.suburb = @bis ? @billing.suburb : params[:s_suburb]
    @shipping.state = @bis ? @billing.state : params[:s_state]
    @shipping.postcode = @bis ? @billing.postcode : params[:s_postcode]
    @shipping.save
    @user.shipping_id = @shipping.id

    if @user.save
      flash[:success] = 'Addresses have saved.'
    else
      flash[:danger] = 'Addresses were not saved.'
    end

    redirect_to admin_user_addresses_path(@user)
  end
end
