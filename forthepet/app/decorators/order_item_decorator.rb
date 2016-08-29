class OrderItemDecorator < BaseDecorator
  def print_total
    h.number_to_currency(object.total)
  end

  def total
    h.number_to_currency(object.total)
  end

  def product_name
    product = object.variant.product

    if product.brand
      "#{product.brand} #{product.name}"
    else
      product.name
    end
  end
end
