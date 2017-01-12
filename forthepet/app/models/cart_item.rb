class CartItem < ActiveRecord::Base
  include RepeatDeliverable

  belongs_to :cart, counter_cache: true
  belongs_to :variant

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def inactive!
    self.is_active = false
    save!
  end

  def total
    variant.price * quantity
  end

  def first_photo
    variant.product.photos.first.picture_url(:cart) rescue ''
  end

  def name
    "#{variant.product.brand} #{variant.product.name}"
  end

  def has_repeat_delivery?
    attributes['frequency'].in? 1..10
  end
end
