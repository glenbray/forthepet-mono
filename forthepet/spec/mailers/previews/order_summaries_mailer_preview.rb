# Preview all emails at http://localhost:3000/rails/mailers/order_summaries_mailer
class OrderSummariesMailerPreview < ActionMailer::Preview

  def summaries_report
    @orders = OrderDecorator.decorate_collection(Order.pending_orders.order(created_at: :desc))
    @grouped_order_items = OrderItem.pending_orders_group_by_deals
  end

end
