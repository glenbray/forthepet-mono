class Admin::SubscriptionsController < Admin::AdminController
  add_crumb 'Subscriptions', '/admin/subscriptions'

  def index
    @q = Subscription.order(id: :desc).search(params[:q])
    @subscriptions = @q.result.page(params[:page])
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def cancel
    subscription = Subscription.find params[:id]
    subscription.cancel!
    flash[:notice] = "Subscription ##{subscription.id} is cancelled!"
    redirect_to admin_subscriptions_path
  end
end
