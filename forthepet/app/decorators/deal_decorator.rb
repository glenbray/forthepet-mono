class DealDecorator < BaseDecorator

  def title
    h.truncate(object.name, length: 50, separator: ' ')
  end

  def available_on
    format_date_time(object.available_on)
  end

  def ends_on
    format_date_time(object.ends_on)
  end

  def ends_on_server_time
    object.ends_on.localtime.strftime('%Y/%m/%d %H:%M:%S %:z')
  end

  def product_with_variants?
    object.product.has_variants?
  end

  def product_description
    object.product.description
  end

  def deals_price
    price = h.number_to_currency(price_or_lowest_price)
    tag = ''

    if object.product.has_variants?
      tag = h.content_tag(:div, class: 'product-price') do
        h.content_tag(:h4, "Low as #{price}")
      end
    else
      master_variant_price = object.product.master_variant.price
      if master_variant_price == price
        tag = h.content_tag(:div, class: 'product-price') do
          h.content_tag(:h4, "Low as #{price}")
        end
      else
        tag = h.content_tag(:div, class: 'deal-price') do
          h.content_tag(:h4, "ONLY #{h.number_to_currency(master_variant_price)}")
        end

        tag += h.content_tag(:div, class: 'deal-discount') do
          h.content_tag(:h4, "NOW #{price}")
        end
      end
    end

    tag.html_safe
  end

  def percentage_saved
    if object.product.has_variants?
      "Save up to #{highest_percentage_saved}%"
    else
      "Save #{highest_percentage_saved}%"
    end
  end

  def photos?
    return false if object.product.nil?
    object.product.photos?
  end

  def first_image
    object.product.photos.first.picture_url(:deal)
  end

  def status
    object.active? ? 'Active' : 'Finished'
  end

  def process_deal?
    return true if object.order_items.count > 0
    return false if object.active?
    false
  end

end
