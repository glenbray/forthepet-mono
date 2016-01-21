class Variant < ActiveRecord::Base
  belongs_to :product
  has_and_belongs_to_many :option_values
  has_many :cart_items
  has_many :order_items

  delegate :name, to: :product

  validates :price, presence: true
  validates_inclusion_of :is_master, :in => [true, false]

  accepts_nested_attributes_for :option_values

  def to_s
    option_values.map(&:name).join(' ')
  end

end
