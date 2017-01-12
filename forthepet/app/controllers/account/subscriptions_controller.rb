class Account::SubscriptionsController < Account::AccountController
  def index
  end

  def cancel
    subscription = current_user.subscriptions.find params[:id]
    subscription.cancel!
    flash[:notice] = "Subscription to #{subscription.variant.name} is cancelled!"
    redirect_to account_root_path
  end
end
