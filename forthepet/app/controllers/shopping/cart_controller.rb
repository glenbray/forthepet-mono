class Shopping::CartController < ApplicationController
  before_filter :coupon_discount

  def index
    @cart = session_cart
    @cart_items = cart_items

    @postage = CalculatePostage.calculate(session_cart, session[:postcode])
  end

  def calculate_postage
    postcode = params[:postage][:postcode]
    session[:postcode] = postcode

    @postage = CalculatePostage.calculate(session_cart, postcode)
  end

  def calculate_coupon
    @postage = CalculatePostage.calculate(session_cart, session[:postcode])

    code = params['coupon']['code']
    coupon_code = CouponCode.find_by(code: code)

    if coupon_code.nil?
      session[:coupon_discount] = 0
      session[:coupon_code_id] = nil
      flash[:invalid_coupon] = 'Invalid Coupon code'
    elsif coupon_code.order_id.present?
      flash[:invalid_coupon] = 'Coupon already used'
    else
      session[:coupon_code_id] = coupon_code.id
      session[:coupon_discount] = coupon_code.coupon.amount
      flash[:invalid_coupon] = nil
    end
  end

  private

  def coupon_discount
    session[:coupon_discount] ||= 0
  end

  def cart_items
    return nil if session_cart.nil?
    CartItemDecorator.decorate_collection(session_cart.cart_items)
  end
end
