class Shopping::CartItemsController < ApplicationController
  def create_variant
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user_id = current_user.nil? ? nil : current_user.id

    if cookies[:cart_id].blank?
      cart = Cart.create
      cookies[:cart_id] = cart.id
    end

    session_cart.add_item(@cart_item)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    quantity = params[:cart_item][:quantity]

    @cart_item.update_attribute(:quantity, quantity)
    @cart_items = cart_items

    @postage = CalculatePostage.calculate(session_cart, session[:postcode])
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = cart_items
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:variant_id, :quantity)
  end

  def cart_items
    return nil if session_cart.nil?
    CartItemDecorator.decorate_collection(session_cart.cart_items.reload)
  end

end
