class FixAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :unit_no
    remove_column :addresses, :street_no
    remove_column :addresses, :street_name
    remove_column :addresses, :street_type
    add_column :addresses, :street_address, :string
  end
end
