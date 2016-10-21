class CouponCode < ActiveRecord::Base
  belongs_to :coupon
  has_many :orders
end
