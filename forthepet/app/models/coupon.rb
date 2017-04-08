class Coupon < ActiveRecord::Base
  has_many :coupon_codes

  def generate_codes(num)
    num.times do
      coupon_code = coupon_codes.build
      coupon_code.generate_code
    end
  end
end
