class DropStockCountProducts < ActiveRecord::Migration
  def change
    remove_column :products, :stock_count
    add_column :variants, :quantity, :integer
  end
end
