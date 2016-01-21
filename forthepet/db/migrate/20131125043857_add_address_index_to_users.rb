class AddAddressIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :address_id
    add_index :users, :billing_id
  end
end
