class Shopping::CartController < ApplicationController
  def index
    @cart = session_cart
    @cart_items = cart_items

    @postage = CalculatePostage.calculate(session_cart)
  end

  def calculate_postage
    postcode = params[:postage][:postcode]
    session[:postcode] = postcode

    @postage = CalculatePostage.calculate(session_cart, postcode)
  end

  private

  def cart_items
    return nil if session_cart.nil?
    CartItemDecorator.decorate_collection(session_cart.cart_items)
  end
end
