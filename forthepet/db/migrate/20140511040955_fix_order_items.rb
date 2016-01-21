class FixOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :orderable_id
    remove_column :order_items, :orderable_type
    add_column :order_items, :variant_id, :integer
    add_index :order_items, :variant_id
  end
end
