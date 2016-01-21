class Option < ActiveRecord::Base
  validates :name, presence: true

  has_many :option_values, -> { order('position ASC') }
  has_and_belongs_to_many :products
end
