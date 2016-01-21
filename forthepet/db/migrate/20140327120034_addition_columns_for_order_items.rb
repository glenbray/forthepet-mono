class AdditionColumnsForOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :quantity, :integer
    add_column :order_items, :supplier_id, :integer
    add_index :order_items, :supplier_id
  end
end
