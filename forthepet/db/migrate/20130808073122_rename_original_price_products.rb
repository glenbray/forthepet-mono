class RenameOriginalPriceProducts < ActiveRecord::Migration
  def change
    rename_column :products, :original_price, :retail_price
  end
end
