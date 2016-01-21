class DropTableProductsProperties < ActiveRecord::Migration
  def change
    drop_table :products_properties
  end
end
