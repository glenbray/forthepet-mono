class Deal < ActiveRecord::Base
  belongs_to :product
  has_many :deal_prices, dependent: :destroy
  has_many :order_items
  has_and_belongs_to_many :fine_prints, join_table: 'deal_fine_prints'

  scope :load_associations,    -> { includes(deal_prices: [:variant], product: [:categories, :photos, :master_variant, :variants]) }
  scope :deal,                 -> (id) { includes(product: [:photos]).friendly.find(id) }
  scope :active,               -> { where('deals.available_on <= ? AND deals.ends_on > ? AND deals.product_id is not NULL', Time.now, Time.now) }
  scope :active_deals,         -> { load_associations.active.order(:ends_on) }
  scope :product_deals,        -> (name) { where(categories: { name: ['All', name] }) }
  scope :active_product_deals, -> (name) { active_deals.product_deals(name) }

  accepts_nested_attributes_for :deal_prices

  extend FriendlyId
  friendly_id :name, use: :slugged

  def fine_prints_with_defaults
    fine_prints | FinePrint.default_fine_prints
  end

  def active?
    !!product && available? && !ended?
  end

  def original_price
    product.master_variant.price
  end

  def product_name
    brand = product.brand
    name = product.name
    brand.blank? ? name : "#{brand} - #{name}"
  end

  def ended?
    (ends_on ? (ends_on < Time.now) : false)
  end

  def price_or_lowest_price
    if product.has_variants?
      deal_prices.map(&:price).min
    else
      variant_id = product.master_variant.id
      deal_prices.find_by_variant_id(variant_id).price
    end
  end

  def highest_percentage_saved
    if product.has_variants?
      deal_prices.maximum(:percentage_saved)
    else
      variant_id = product.master_variant.id
      deal_prices.find_by_variant_id(variant_id).percentage_saved
    end
  end

  private

  def available?
    available_on ? (available_on <= Time.now) : false
  end
end
