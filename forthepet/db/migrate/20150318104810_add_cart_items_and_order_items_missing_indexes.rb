class AddCartItemsAndOrderItemsMissingIndexes < ActiveRecord::Migration
  def change
    add_index :cart_items, :variant_id
    add_index :order_items, :deal_id
  end
end
