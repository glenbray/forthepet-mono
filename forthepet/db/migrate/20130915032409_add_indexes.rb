class AddIndexes < ActiveRecord::Migration
  def change
    add_index :variants, :product_id
    add_index :photos, :product_id
    add_index :products, :supplier_id, unique: true
    add_index :options_products, [:product_id, :option_id]
    add_index :option_values, :option_id
    add_index :deals, :product_id
    add_index :cart_items, [:user_id, :cart_id, :variant_id]
    add_index :carts, :user_id
    add_index :products_properties, [:product_id, :property_id]
  end
end
