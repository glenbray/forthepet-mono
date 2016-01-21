class AddMoreColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_firstname, :string
    add_column :orders, :shipping_surname, :string
    add_column :orders, :billing_phone, :string
    add_column :orders, :shipping_phone, :string
    rename_column :orders, :firstname, :billing_firstname
    rename_column :orders, :surname, :billing_surname
    remove_column :orders, :phone_number
    remove_column :orders, :email
    remove_column :orders, :total_amount
    remove_column :orders, :use_billing
  end
end
