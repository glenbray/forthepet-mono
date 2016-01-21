class RenameQuantityCartItemsCountCart < ActiveRecord::Migration
  def change
    remove_column :carts, :quantity
    add_column :carts, :cart_items_count, :integer, default: 0
  end
end
