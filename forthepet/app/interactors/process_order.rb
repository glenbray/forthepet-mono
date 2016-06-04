class ProcessOrder
  def initialize(order, cart)
    @order = order
    @cart = cart
    @user = order.user
  end

  def process
    @order.total = @cart.total
    save_cart_to_order
    @order.paid!
    @order.touch(:purchased_at)
    customer_invoice
    update_user_referrals
  end

  private

  def save_cart_to_order
    @cart.cart_items.each do |cart_item|
      attributes = cart_item_attributes(cart_item)
      order_item = create_order_item(attributes)
      order_item.pay!
    end
  end

  def cart_item_attributes(cart_item)
    v_id = cart_item.variant_id
    {
      quantity:   cart_item.quantity,
      variant_id: v_id,
      price:      cart_item.variant.price
    }
  end

  def create_order_item(params)
    order_item = @order.order_items.build(params)
    order_item.save
    order_item
  end

  def customer_invoice
    CustomerMailer.delay.customer_invoice(@order)
  end

  def update_user_referrals
    return if @user.nil? || (orders_count > 1 || @user.referred_by.nil?)

    update_referrer_referrals
    apply_referral_discount
  end

  def update_referrer_referrals
    return if referrer.nil?
    referral = referrer.referrals.build(email: @user.email)
    referral.save
  end

  def apply_referral_discount
    user_discount = referrer.user_discounts.build
    user_discount.discount = Discount.find_by_description('Referral Discount')
    user_discount.save
  end

  def orders_count
    @order_count ||= @user.orders.count
  end

  def referrer
    @referrer ||= User.find_by_email(@user.referred_by)
  end

  # def email_supplier(order_item)
  #   SupplierMailer.delay.new_order(order_item)
  # end

end
