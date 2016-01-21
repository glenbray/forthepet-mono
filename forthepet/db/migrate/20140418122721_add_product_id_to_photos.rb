class AddProductIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :product_id, :integer
    remove_column :photos, :item_id

    add_index :photos, :product_id
  end
end
