class AddColumnsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :order_id, :integer
    add_column :order_items, :deal_id, :integer
    add_column :order_items, :orderable_id, :integer
    add_column :order_items, :orderable_type, :string

    add_index :order_items, :order_id
    add_index :order_items, [:orderable_id, :orderable_type]
  end
end
