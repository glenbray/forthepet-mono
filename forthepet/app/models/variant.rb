class Variant < ActiveRecord::Base
  before_save :calculate_percentage_saved

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

  private

  def calculate_percentage_saved
    self.original_price ||= price

    amount_saved = original_price - price
    self.percentage_saved = amount_saved / price * 100
  end
end
