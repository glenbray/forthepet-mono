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


    # DealPrice.all.each do |d|
    #   percentage = d.price / d.variant.price * 100
    #   d.percentage_saved =  percentage.round
    #   d.save
    # end

    # add_column :products, :is_active_tmp, :boolean, default: true

    # Product.all.each { |p| p.update(is_active_tmp: false) }
    # Deal.active.each { |deal| deal.product.update(is_active_tmp: true) }
    # remove_column :products, :is_active
    # rename_column :products, :is_active_tmp, :is_active
  end
end
