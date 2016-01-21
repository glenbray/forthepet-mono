class AddIndexToCategoriesProducts < ActiveRecord::Migration
  def change
    add_index :categories_items, [:category_id, :item_id]
  end
end
