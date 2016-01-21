class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_first_name, :string
    add_column :orders, :billing_last_name, :string
    add_column :orders, :billing_address1, :string
    add_column :orders, :billing_suburb, :string
    add_column :orders, :billing_state, :string
    add_column :orders, :billing_postcode, :integer
    add_column :orders, :shipping_first_name, :string
    add_column :orders, :shipping_last_name, :string
    add_column :orders, :shipping_address1, :string
    add_column :orders, :shipping_suburb, :string
    add_column :orders, :shipping_state, :string
    add_column :orders, :shipping_postcode, :integer
  end
end
