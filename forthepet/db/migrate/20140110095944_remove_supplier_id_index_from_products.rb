class RemoveSupplierIdIndexFromProducts < ActiveRecord::Migration
  def change
    remove_index :products, :supplier_id
  end
end
