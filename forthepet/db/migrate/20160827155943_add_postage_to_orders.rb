class AddPostageToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :postage, :decimal, default: 0.0

    Order.update_all(postage: 0)
  end
end
