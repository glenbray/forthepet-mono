class AddDealPriceToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :deal_price, :decimal
  end
end
