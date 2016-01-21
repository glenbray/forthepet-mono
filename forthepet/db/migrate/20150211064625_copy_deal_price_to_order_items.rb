class CopyDealPriceToOrderItems < ActiveRecord::Migration
  def up
    OrderItem.all.each do |order_item|
      order_item.price = order_item.deal.price
      order_item.save
    end
  end
end
