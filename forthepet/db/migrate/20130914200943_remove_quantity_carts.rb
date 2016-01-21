class RemoveQuantityCarts < ActiveRecord::Migration
  def change
    remove_column :cart_items, :quantity
  end
end
