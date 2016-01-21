class AddPolymorphicToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :cartable_id, :integer
    add_column :cart_items, :cartable_type, :string
    add_index :cart_items, [:cartable_id, :cartable_type]
    remove_index :cart_items, name: 'index_cart_items_on_user_id_and_cart_id_and_variant_id'
    remove_column :cart_items, :variant_id
  end
end
