class Admin::OrderDealsController < Admin::AdminController
  def index
    deals = Deal.includes(:order_items)
    @deal_orders = DealDecorator.decorate_collection(deals)
  end

  def show
    @deal = Deal.find(params[:id])
    @order_items = @deal.order_items
  end
end
