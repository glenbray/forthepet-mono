class CreateCouponCodes < ActiveRecord::Migration
  def change
    create_table :coupon_codes do |t|
      t.references :coupon
      t.references :order
      t.string :code

      t.timestamps null: false
    end
    add_index :coupon_codes, :code, unique: true
  end
end
