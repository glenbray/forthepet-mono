class Admin::OrderProcessingController < Admin::AdminController
  add_crumb 'Order Processing', '/admin/order-processing'

  respond_to :html, :js

  before_filter :load_order_and_orders, only: [:index, :tracking_no, :courier]

  def index
  end

  def show
    respond_to do |format|
      format.js { @order = Order.find(params[:order_id]).decorate }
    end
  end

  def received
    order_item = OrderItem.find(params[:order_item_id])
    flash[:success] = "Order #{order_item.id} has now been received"
    order_item.received!
    redirect_to admin_order_processing_index_path
  end

  def shipping
    order_item = OrderItem.find(params[:order_item_id])
    flash[:success] = "Order #{order_item.id} status updated to shipped"
    redirect_to admin_order_processing_index_path
  end

  def tracking_no
    respond_to do |format|
      format.js {
        if @order.update(tracking_no: params[:order][:tracking_no])
          flash[:success] = "Order #{@order.id} tracking no updated"
        else
          flash[:danger] = 'Error updating tracking no'
        end
       }
    end
  end

  def courier
    respond_to do |format|
      format.js {
        if @order.update(courier: params[:order][:courier])
          flash[:success] = "Order #{@order.id} courier updated"
        else
          flash[:danger] = 'Error updating courier'
        end
       }
    end
  end

  def ship_it
    order = Order.find(params[:order_id])
    if order.ship_it
      CustomerMailer.delay.shipping_order(order)
      flash[:success] = "Order #{order.id} status has been updated to 'shipped'"
    else
      flash[:danger] = 'There was a problem while processing items'
    end
    redirect_to admin_order_processing_index_path
  end

  private

  def load_order_and_orders
    @orders = OrderDecorator.decorate_collection(Order.pending_orders.order(created_at: :asc))
    @order = find_order_or_get_first.try(:decorate)
  end

  def find_order_or_get_first
    params[:order_id].present? ? Order.find(params[:order_id]) : @orders.first
  end
end
