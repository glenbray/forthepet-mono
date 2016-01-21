class AddPurchaseLimitToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :purchase_limit, :integer
  end
end
