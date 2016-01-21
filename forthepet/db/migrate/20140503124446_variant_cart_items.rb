class VariantCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :variant_id, :integer
    remove_column :cart_items, :product_id
  end
end
