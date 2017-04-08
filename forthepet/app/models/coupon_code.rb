class CouponCode < ActiveRecord::Base
  belongs_to :coupon
  has_one :order

  validates :code, uniqueness: true

  def generate_code
    begin
      self.code = SecureRandom.hex(4)
      save
    rescue ActiveRecord::RecordNotUnique
      generate_code
    end
  end
end
