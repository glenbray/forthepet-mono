class AddUserIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :user_id, :integer
    add_column :addresses, :first_name, :string
    add_column :addresses, :last_name, :string
    add_column :addresses, :company, :string
    add_column :addresses, :mobile, :string
    add_column :addresses, :phone, :string

    remove_column :orders, :billing_firstname
    remove_column :orders, :billing_surname
    remove_column :orders, :billing_company
    remove_column :orders, :shipping_address1
    remove_column :orders, :shipping_address2
    remove_column :orders, :shipping_suburb
    remove_column :orders, :shipping_state
    remove_column :orders, :shipping_postcode
    remove_column :orders, :billing_address1
    remove_column :orders, :billing_address2
    remove_column :orders, :billing_suburb
    remove_column :orders, :billing_state
    remove_column :orders, :billing_postcode
    remove_column :orders, :shipping_firstname
    remove_column :orders, :shipping_surname
    remove_column :orders, :billing_phone
    remove_column :orders, :shipping_phone
    remove_column :orders, :shipping_company
    remove_column :orders, :billing_mobile
    remove_column :orders, :shipping_mobile
  end
end
