class ChangeVariantOriginalPriceType < ActiveRecord::Migration
  def change
    change_column :variants, :original_price, :decimal
  end
end
