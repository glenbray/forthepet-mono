class AddAdditionalAddressToAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :street_address, :address1
    add_column :addresses, :address2, :string
  end
end
