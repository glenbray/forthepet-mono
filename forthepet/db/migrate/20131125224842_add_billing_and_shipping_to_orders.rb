class AddBillingAndShippingToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :firstname, :string
    add_column :orders, :surname, :string
    add_column :orders, :company, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :email, :string

    add_column :orders, :shipping_address1, :string
    add_column :orders, :shipping_address2, :string
    add_column :orders, :shipping_suburb, :string
    add_column :orders, :shipping_state, :string
    add_column :orders, :shipping_postcode, :integer

    add_column :orders, :billing_address1, :string
    add_column :orders, :billing_address2, :string
    add_column :orders, :billing_suburb, :string
    add_column :orders, :billing_state, :string
    add_column :orders, :billing_postcode, :integer

    rename_column :deals, :deal_price, :price
  end
end
