class Account::ShippingAddressesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shipping = Address.new(shipping_params)
    @shipping.user_id = current_user.id
    if @shipping.save
      current_user.shipping_id = @shipping.id
      current_user.save
      flash[:success] = 'Shipping address saved.'
      redirect_to account_root_path
    else
      flash[:danger] = 'Shipping address was not saved.'
      render(json: @shipping.errors.full_messages) && return
      redirect_to account_root_path
    end
  end

  def update
    @shipping = Address.find(params[:id])
    if @shipping.update(shipping_params)
      flash[:success] = 'Shipping address updated.'
      redirect_to account_root_path
    else
      flash[:danger] = 'Shipping address was not updated.'
      redirect_to account_root_path
    end
  end

  private

  def shipping_params
    params.require(:address).permit(
     :first_name,
     :last_name,
     :address1,
     :address2,
     :suburb,
     :state,
     :postcode
   )
   end
end
