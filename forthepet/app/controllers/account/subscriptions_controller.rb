class Account::SubscriptionsController < Account::AccountController
  def index
    @subscriptions = current_user.subscriptions
  end

  def edit
    @subscription = current_user.subscriptions.find params[:id]
    @braintree = @subscription.payment_method.braintree
    @client_token = Braintree::ClientToken.generate
  end

  def update
    subscription = current_user.subscriptions.find params[:id]
    result = Braintree::PaymentMethod.create(
        customer_id: current_user.braintree_customer_id,
        payment_method_nonce: params[:payment_method_nonce]
      )

    if result.success?
      payment_method = current_user.payment_methods.create(
        braintree_token: result.payment_method.token
      )
    end

    if payment_method
      subscription.update! payment_method: payment_method
      flash[:notice] = 'Payment method is updated successfully!'
      redirect_to account_subscriptions_path
    else
      flash[:error] = 'Invalid payment method!'
      render :edit
    end
  end

  def change_frequency
    subscription = current_user.subscriptions.find params[:id]
    subscription.update! frequency: params[:frequency]
    flash[:notice] = "Subscription to #{subscription.variant.name} is updated!"
    render js: "window.location.href='#{account_subscriptions_path}'"
  end

  def cancel
    subscription = current_user.subscriptions.find params[:id]
    subscription.cancel!
    flash[:notice] = "Subscription to #{subscription.variant.name} is cancelled!"
    redirect_to account_subscriptions_path
  end

  def pause
    subscription = current_user.subscriptions.find params[:id]
    subscription.pause!
    flash[:notice] = "Subscription to #{subscription.variant.name} is place on hold!"
    redirect_to account_subscriptions_path
  end

  def resume
    subscription = current_user.subscriptions.find params[:id]
    subscription.resume!
    flash[:notice] = "Subscription to #{subscription.variant.name} is resumed"
    redirect_to account_subscriptions_path
  end
end
