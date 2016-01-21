class CreateDealPrices < ActiveRecord::Migration
  def change
    create_table :deal_prices do |t|
      t.references :deal, index: true, foreign_key: true
      t.references :variant, index: true, foreign_key: true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
