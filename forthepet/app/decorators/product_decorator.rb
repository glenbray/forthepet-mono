class ProductDecorator < BaseDecorator
  def short_description
    description = object.description
    sanitized = ActionView::Base.full_sanitizer.sanitize(description)
    sanitized = sanitized.gsub(/\n?/, "").gsub("&#13", "").gsub(";", " ").gsub(/(\s|\u00A0)+/, ' ')
    h.truncate(sanitized, length: 150, omission: '...')
  end

  def first_image
    object.photos.first.picture_url(:product)
  end

  def price
    price = h.number_to_currency(price_or_lowest_price)
    tag = ''

    if object.has_variants?
      tag = h.content_tag(:div, class: 'product-price') do
        h.content_tag(:h4, "Low as #{price}")
      end
    else
      master_variant_price = object.master_variant.price
      if master_variant_price == object.master_variant.original_price
        tag = h.content_tag(:div, class: 'product-price') do
          h.content_tag(:h4, "Low as #{price}")
        end
      else
        tag = h.content_tag(:div, class: 'product-original-price') do
          h.content_tag(:h4, "was #{h.number_to_currency(object.master_variant.original_price)}")
        end

        tag += h.content_tag(:div, class: 'product-discount') do
          h.content_tag(:h4, "NOW #{price}")
        end
      end
    end

    tag.html_safe
  end

  def percentage_saved
    if object.has_variants?
      "Save up to #{highest_percentage_saved}%"
    else
      "Save #{highest_percentage_saved}%"
    end
  end

end
