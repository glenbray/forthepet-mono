class Account::BillingAddressesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @billing = Address.new(billing_params)
    @billing.user_id = current_user.id
    if @billing.save
      current_user.billing_id = @billing.id
      current_user.save
      flash[:success] = 'Billing address saved.'
      if billing_params[:billing_is_shipping] == '1'
        @shipping = Address.new(billing_params)
        @shipping.user_id = current_user.id
        if @shipping.save
          current_user.shipping_id = @shipping.id
          current_user.save
          flash[:success] = 'Billing address saved and shipping address is the billing address.'
        else
          flash[:danger] = "Billing address was saved, but we couldn't save the shipping address."
          redirect_to account_root_path
        end
      end
      redirect_to account_root_path
    else
      flash[:danger] = 'Billing address was not saved.'
      redirect_to account_root_path
    end
  end

  def update
    @billing = Address.find(params[:id])
    if @billing.update(billing_params)
      flash[:success] = 'Billing address updated.'

      if billing_params[:billing_is_shipping] == '1'
        @shipping = current_user.shipping
        if @shipping # If exists to be updated
          if @shipping.update(billing_params)
            flash[:success] = 'Billing address updated and shipping address is the billing address.'
          else
            flash[:danger] = 'Billing address updated, however shipping was unable to update.'
          end
        else # Creating new shipping
          @shipping = Address.new(billing_params)
          @shipping.user_id = current_user.id
          if @shipping.save
            current_user.shipping_id = @shipping.id
            current_user.save
          else
            flash[:danger] = "Billing address was updated, but we couldn't create the shipping address."
          end
        end
     end

      redirect_to account_root_path
    else
      flash[:danger] = 'Billing address was not updated.'
      redirect_to account_root_path
    end
  end

  private

  def billing_params
    params.require(:address).permit(:first_name, :last_name, :address1, :address2, :suburb, :state, :postcode, :billing_is_shipping)
   end
end
