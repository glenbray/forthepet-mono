module Admin::VariantHelper

  def option_values
    @product.options.map(&:option_values).flatten.map { |option_value| [option_value.name, option_value.id] }
  end

  def product_photos
    @product.photos.map { |photo| [ image_tag(photo.picture_url(:thumbnail), alt: photo.alt_text), photo.id] }
  end

end
