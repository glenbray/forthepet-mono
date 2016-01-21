class Admin::OrderSummariesController < Admin::AdminController
  add_crumb 'Orders', '/admin/orders'

  def index
    @orders = OrderDecorator.decorate_collection(Order.pending_orders.order(created_at: :desc))
    @grouped_order_items = OrderItem.pending_orders_group_by_deals

    add_crumb 'Summaries Report'
  end

  def email
    OrderSummariesMailer.delay.summaries_report

    flash[:success] = 'Summaries report email sent'
    redirect_to admin_order_summaries_path
  end
end
