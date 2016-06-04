class Product < ActiveRecord::Base
  belongs_to :supplier, autosave: true
  belongs_to :category, autosave: true
  has_many :photos, -> { order("position ASC") }
  has_many :deals
  has_many :features

  has_one :master_variant, -> { where is_master: true },
          class_name: 'Variant', dependent: :destroy

  has_many :variants, -> { where(is_master: false).order('position ASC') }
  has_and_belongs_to_many :options

  accepts_nested_attributes_for :master_variant, allow_destroy: true

  scope :products, -> { load_associations.active }
  scope :single, -> { load_associations.active.includes(variants: [:option_values]) }
  scope :load_associations, -> { includes(:category, :photos, :master_variant) }
  scope :active, -> { load_associations.where(is_active: true) }
  scope :filter_categories, -> (categories) { active.where(categories: { name: ['All', categories] }) }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  paginates_per 25

  def title
    "#{brand} #{name}"
  end

  def short_description
    description[0..150]
  end

  def master_variant?
    variants.empty? ? true : false
  end

  def highest_percentage_saved
    if has_variants?
      variants.maximum(:percentage_saved)
    else
      master_variant.percentage_saved
    end
  end

  def price_or_lowest_price
    if has_variants?
      variants.map(&:price).min
    else
      master_variant.price
    end
  end

  def photos?
    photos.empty? ? false : true
  end

  def update_options(option_ids)
    options.delete_all
    options << Option.where(id: option_ids)
  end

  def has_variants?
    variants.present?
  end
end
