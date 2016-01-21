class RemovePriceFromDeals < ActiveRecord::Migration
  def change
    Deal.all.each do |d|
      DealPrice.create(variant_id: d.product.master_variant.id,
                       deal_id: d.id,
                       price: d.price)
    end

    remove_column :deals, :price
  end
end
