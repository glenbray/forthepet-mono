class AddProductIdToDeals < ActiveRecord::Migration
  def up
    add_column :deals, :product_id, :integer
  end

  def down
    remove_column :deals, :product_id
  end
end
