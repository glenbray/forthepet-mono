class OrderSummariesMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  SEND_TO = ['glen.bray@gmail.com', 'DanielC@petshopboyz.com.au']

  default from: 'orders@forthepet.com.au', to: SEND_TO

  def summaries_report
    @orders = OrderDecorator.decorate_collection(Order.pending_orders.order(created_at: :desc))
    @grouped_order_items = OrderItem.pending_orders_group_by_deals
    @orders_total = @grouped_order_items.inject(0) { |sum, deal| sum += deal.last.sum(&:total) }

    mail(subject: "Order Summaries")
  end

end
