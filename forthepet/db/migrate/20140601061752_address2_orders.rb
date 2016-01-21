class Address2Orders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_address2, :string
    add_column :orders, :billing_mobile, :string
    add_column :orders, :billing_phone, :string
    add_column :orders, :shipping_address2, :string
    add_column :orders, :shipping_mobile, :string
    add_column :orders, :shipping_phone, :string
  end
end
