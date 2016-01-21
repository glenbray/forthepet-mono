class OrderDecorator < BaseDecorator
  decorates_association :order_items

  def created_at
    format_date_time(object.created_at)
  end

  def purchased_at
    format_date_time(object.purchased_at)
  end

  def total
    total = !!object.total ? two_decimals(object.total) : 0
    "$#{total}"
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

end
