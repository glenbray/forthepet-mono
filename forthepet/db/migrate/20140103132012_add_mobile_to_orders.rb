class AddMobileToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_mobile, :string
    add_column :orders, :shipping_mobile, :string
  end
end
