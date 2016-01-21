class ChangeAddressIdToShippingIdForAddresses < ActiveRecord::Migration
  def change
    rename_column :users, :address_id, :shipping_id
  end
end
