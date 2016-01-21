class Admin::OrdersController < Admin::AdminController
  add_crumb 'Orders', '/admin/orders'

  def index
    @q = Order.order(created_at: :desc).search(params[:q])
    @q.aasm_state_cont = :pending unless params[:q]
    @orders = OrderDecorator.decorate_collection(@q.result.page(params[:page]))
  end

  def show
    @order = Order.includes(order_items: [:deal]).find(params[:id]).decorate
    @order_items = @order.order_items
    add_crumb 'Order Items'
  end

  def email
    order = Order.find(params[:order_id])
    flash[:success] = 'Order email sent to user'
    CustomerMailer.delay.customer_invoice(order)
    redirect_to admin_order_url(order)
  end

end
