class RemovePolyCartItems < ActiveRecord::Migration
  def change
    remove_column :cart_items, :cartable_id
    remove_column :cart_items, :cartable_type
    add_column :cart_items, :product_id, :integer
  end
end
