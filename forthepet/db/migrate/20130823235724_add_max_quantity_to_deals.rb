class AddMaxQuantityToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :max_quantity, :integer
  end
end
