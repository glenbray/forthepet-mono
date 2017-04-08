class Admin::CouponsController < Admin::AdminController
  def index
    @coupons = Coupon.all
  end

  def show
    @coupon = Coupon.find(params[:id])
  end
end
