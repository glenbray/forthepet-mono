class CartItemDecorator < BaseDecorator
  def price
    # v_id = object.variant.id
    # price = object.deal.deal_prices.find_by_variant_id(v_id).price
    price = object.variant.price
    "$ #{two_decimals(price)}"
  end

  def total_price
    total = object.total
    "$ #{two_decimals(total)}"
  end
end
