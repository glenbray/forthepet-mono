class AddItemIdToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :item_id, :integer
    remove_column :deals, :picture
    remove_column :deals, :product_id
  end
end
