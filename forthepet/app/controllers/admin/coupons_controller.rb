class Admin::CouponsController < Admin::AdminController
  def index
    @coupons = Coupon.all
  end

  def new
  end
end
