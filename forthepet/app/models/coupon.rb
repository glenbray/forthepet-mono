class Coupon < ActiveRecord::Base
  has_many :coupon_codes
end
