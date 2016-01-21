class RemoveAddressableFromAddresses < ActiveRecord::Migration
  def change
    remove_index :addresses, name: :index_addresses_on_addressable_id_and_addressable_type
    remove_column :addresses, :addressable_id
    remove_column :addresses, :addressable_type
  end
end
