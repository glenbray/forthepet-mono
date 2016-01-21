class FinePrint < ActiveRecord::Base
  has_and_belongs_to_many :deals, join_table: 'deal_fine_prints'
  scope :default_fine_prints, -> { where(is_default: true) }
end
