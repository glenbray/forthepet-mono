class AddSubscriptionIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subscription_id, :integer
    add_index :orders, :subscription_id
  end
end
