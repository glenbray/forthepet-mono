class Shopping::CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!, only: [:show], if: :has_repeat_delivery?

  layout '../shopping/checkout/wizard'
  add_crumb 'Shopping Cart', '/cart'

  steps :details, :payment, :summary

  def show
    @cart = session_cart
    @postage = CalculatePostage.calculate(session_cart, session[:postcode])

    case step
    when :summary
      clear_cart_session
    when :payment
      unless checkout_form.validate(session_order.attributes)
        redirect_to wizard_path(:details) and return
      else
        @client_token = Braintree::ClientToken.generate
        @amount = session_cart.total
      end
    else
      checkout_form
    end
    render_wizard
  end

  def update
    case step
    when :details
      if checkout_form.validate(params[:order])
        @postage = CalculatePostage.calculate(session_cart, checkout_form.shipping_postcode)
        session[:postcode] = @postage.postcode

        render_wizard(checkout_form)
      else
        render_wizard
      end
    end
  end

  def create
    nonce = params[:payment_method_nonce]

    if current_user
      unless current_user.braintree_customer_id.present?
        result = Braintree::Customer.create current_user.slice(:first_name,
          :last_name, :email, :phone)
        if result.success?
          current_user.update_attribute :braintree_customer_id, result.customer.id
        end
      end

      result = Braintree::PaymentMethod.create(
        customer_id: current_user.braintree_customer_id,
        payment_method_nonce: nonce
      )

      if result.success?
        payment_method = current_user.payment_methods.create(
          braintree_token: result.payment_method.token
        )
      end
    end

    postage = CalculatePostage.calculate(session_cart, session[:postcode])

    discount = session[:coupon_discount]

    options = {
      amount: session_cart.total + postage.cost - discount.to_d,
      options: {
        submit_for_settlement: true
      }
    }

    if payment_method
      options[:payment_method_token] = payment_method.braintree_token
    else
      options[:payment_method_nonce] = nonce
    end

    @result = Braintree::Transaction.sale options

    if @result.success?
      session_order.transaction_no = @result.transaction.id
      session_order.postage = postage.cost
      session_order.coupon_code_id = session[:coupon_code_id]
      order = ProcessOrder.new(session_order, session_cart, payment_method)
      order.process
      clear_order_session
      redirect_to wizard_path(:summary)
    else
      @client_token = Braintree::ClientToken.generate
      render file: 'app/views/shopping/checkout/payment.html.slim'
    end
  end

  private

  def checkout_form
    @checkout_form ||= CheckoutForm.new(session_order, current_user)
  end

  def clear_order_session
    session[:order_id] = nil
    session[:coupon_code_id] = nil
    session[:coupon_discount] = nil
  end

  def clear_cart_session
    cookies.delete :rid
    cookies.delete :cart_id
  end

  def session_order
    return @session_order if @session_order
    find_or_create_order
  end

  def find_or_create_order
    if session[:order_id].nil?
      @session_order = Order.create(user_id: current_user&.id)
      session[:order_id] = @session_order.id
    else
      @session_order = Order.find(session[:order_id])
    end
    @session_order
  end

  def has_repeat_delivery?
    session_cart.cart_items.any? &:has_repeat_delivery?
  end

end
