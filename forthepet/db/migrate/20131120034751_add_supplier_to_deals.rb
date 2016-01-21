class AddSupplierToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :supplier_id, :integer
    add_column :cart_items, :supplier_id, :integer
  end
end
