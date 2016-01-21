class MakeAddressPolymorphic < ActiveRecord::Migration
  def change
    add_column :addresses, :addressable_id, :integer
    add_column :addresses, :addressable_type, :string
    add_index :addresses, [:addressable_id, :addressable_type]
  end
end
