class DropColumnOriginalPriceFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :retail_price
    remove_column :products, :discounted_price
  end
end
