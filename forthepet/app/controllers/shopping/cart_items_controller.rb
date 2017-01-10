class Shopping::CartItemsController < ApplicationController
  def create_variant
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user_id = current_user&.id

    if cookies[:cart_id].blank?
      cart = Cart.create
      cookies[:cart_id] = cart.id
    end

    session_cart.add_item(@cart_item)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if params[:frequency]
      @cart_item.update_attribute :frequency, params[:frequency]
      @message = "#{@cart_item.name} delivery frequency has been updated"
    else
      quantity = params[:cart_item][:quantity]
      @cart_item.update_attribute(:quantity, quantity)
      @message = "#{@cart_item.name} quantity has been updated"
    end

    @cart_items = cart_items
    @postage = CalculatePostage.calculate(session_cart, session[:postcode])
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = cart_items
    @postage = CalculatePostage.calculate(session_cart, session[:postcode])
  end

  private

  def cart_item_params
    keys = [:variant_id, :quantity]
    keys << :frequency if params[:repeat_delivery] == "true"
    params.require(:cart_item).permit *keys
  end

  def cart_items
    return nil if session_cart.nil?
    CartItemDecorator.decorate_collection(session_cart.cart_items.reload)
  end

end
