class OptionValue < ActiveRecord::Base
  belongs_to :option
  has_and_belongs_to_many :variants

  validates :name, presence: true
  validates :display, presence: true

  acts_as_list scope: :option
end
