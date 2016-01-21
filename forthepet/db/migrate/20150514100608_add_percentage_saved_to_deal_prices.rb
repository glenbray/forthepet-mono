class AddPercentageSavedToDealPrices < ActiveRecord::Migration
  def change
    add_column :deal_prices, :percentage_saved, :integer

    DealPrice.all.each do |d|
      percentage = d.price / d.variant.price * 100
      d.percentage_saved =  percentage.round
      d.save
    end
  end
end
