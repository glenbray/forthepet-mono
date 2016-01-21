class AddIndexNameSkuProducts < ActiveRecord::Migration
  def change
    add_index :products, :name
    add_index :variants, :sku
  end
end
