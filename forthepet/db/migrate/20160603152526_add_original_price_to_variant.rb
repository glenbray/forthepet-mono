class AddOriginalPriceToVariant < ActiveRecord::Migration
  def change
    add_column :variants, :original_price, :integer
    add_column :variants, :percentage_saved, :integer

    Variant.all.each do |v|
      v.update(original_price: v.price)
      v.original_price = v.price

      deal_price = DealPrice.find_by_variant_id(v.id)

      v.price = deal_price.price if deal_price

      percentage = v.price / v.original_price * 100
      v.percentage_saved = percentage.round
      v.save
    end
  end
end
