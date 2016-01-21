class CopyShortDescriptionToDealDescription < ActiveRecord::Migration
  def change
    Deal.where.not(product_id: nil).each do |deal|
      deal.description = deal.product.decorate.short_description
      deal.save
    end
  end
end