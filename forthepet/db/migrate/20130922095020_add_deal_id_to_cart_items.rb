class AddDealIdToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :deal_id, :integer
    add_index :cart_items, :deal_id
  end
end
