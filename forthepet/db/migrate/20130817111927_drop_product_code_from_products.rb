class DropProductCodeFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :product_code
    remove_column :products, :retail_price
  end
end
