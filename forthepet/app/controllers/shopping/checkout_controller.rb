class Shopping::CheckoutController < ApplicationController
  include Wicked::Wizard

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
    postage = CalculatePostage.calculate(session_cart, session[:postcode])

    nonce = params[:payment_method_nonce]

    @result = Braintree::Transaction.sale(
      amount: session_cart.total + postage.cost,
      payment_method_nonce: nonce,
      options: {
        submit_for_settlement: true
      }
    )

    if @result.success?
      session_order.transaction_no = @result.transaction.id
      session_order.postage = postage.cost
      order = ProcessOrder.new(session_order, session_cart)
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

end
