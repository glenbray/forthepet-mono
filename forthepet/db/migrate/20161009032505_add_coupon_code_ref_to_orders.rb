class AddCouponCodeRefToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :coupon_code, index: true, foreign_key: true
  end
end
