class DealsController < ApplicationController
  def index
    @deals = DealDecorator.decorate_collection(Deal.active_deals)
  end

  def show
    @deal = Deal.deal(params[:id]).decorate
    @product = @deal.product
    @cart_item = CartItem.new(quantity: 1)

    render 'product_deal'
  end
end
