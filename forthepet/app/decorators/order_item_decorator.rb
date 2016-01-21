class OrderItemDecorator < BaseDecorator

  def print_total
    h.number_to_currency(object.total)
  end

  def deal_name
    name = object.deal.name
    option_text = variant.to_s
    name = "#{name} - #{option_text}" unless option_text.blank?
    name
  end

  def total
    h.number_to_currency(object.total)
  end

end
