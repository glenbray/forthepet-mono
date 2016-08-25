class Shopping::CartController < ApplicationController
  def index
    @cart = session_cart
    @cart_items = cart_items
  end

  def calculate_postage
    redirect_to cart_path session_cart
  end

  private

  def cart_items
    return nil if session_cart.nil?
    CartItemDecorator.decorate_collection(session_cart.cart_items)
  end

end
