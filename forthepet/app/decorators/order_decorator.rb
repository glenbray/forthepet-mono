class OrderDecorator < BaseDecorator
  decorates_association :order_items

  def created_at
    format_date_time(object.created_at)
  end

  def purchased_at
    format_date_time(object.purchased_at)
  end

  def subtotal
    subtotal = !!object.total ? two_decimals(object.total) : 0
    "$#{subtotal}"
  end

  def postage
    if object.postage.zero?
      "Free"
    else
      "$#{two_decimals(object.postage)}"
    end
  end

  def discount
    return '$0.00' unless order.coupon_code
    "$#{two_decimals(order.coupon_code.coupon.amount)}"
  end

  def total
    discount = order.coupon_code&.coupon&.amount || 0
    total = object.total + object.postage - discount
    "$#{two_decimals(total)}"
  end

  def shipping_full_name
    "#{shipping_first_name} #{shipping_last_name}"
  end

  def billing_full_name
    "#{billing_first_name} #{billing_last_name}"
  end

  def billing_address
    "#{object.billing_address1} #{object.billing_suburb} #{object.billing_state} #{object.billing_postcode}"
  end

  def shipping_address
    "#{object.shipping_address1} #{object.shipping_suburb} #{object.shipping_state} #{object.shipping_postcode}"
  end

  def user_id
    !!user ? user.id : ''
  end

  def current(order_id)
    order_id.to_i == object.id ? 'active' : ''
  end

  def order_items_total
    total = object.order_items.total
    h.number_to_currency(total)
  end

end
