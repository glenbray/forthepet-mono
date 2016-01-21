class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :addresses, :user_id
    add_index :categories, :name
    add_index :user_discounts, :user_id
    add_index :variants_options, :variant_id
    add_index :variants_options, :option_value_id
  end
end
