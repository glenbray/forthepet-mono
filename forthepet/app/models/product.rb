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
  scope :active, -> { where is_active: true }

  paginates_per 25

  def short_description
    description[0..150]
  end

  def master_variant?
    variants.empty? ? true : false
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
