class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :retail_price, :decimal
  end
end
