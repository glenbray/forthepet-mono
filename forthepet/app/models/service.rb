class Service < ActiveRecord::Base
  has_one :item, as: :itemable
  has_many :cart_items, as: :cartable
  has_many :order_items, as: :orderable
end
