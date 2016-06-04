class CartItem < ActiveRecord::Base
  belongs_to :cart, counter_cache: true
  belongs_to :deal
  belongs_to :variant

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def inactive!
    self.is_active = false
    save!
  end

  def total
    # v_id = variant.id
    # deal.deal_prices.find_by_variant_id(v_id).price * quantity
    variant.price * quantity
  end

  def first_photo
    variant.product.photos.first.picture_url(:cart) rescue ''
  end

  def name
    variant.product.name
  end

end
