class AddPurchasedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :purchased_at, :datetime

    Order.all.each do |order|
      order.purchased_at = order.created_at
      order.save
    end
  end
end
