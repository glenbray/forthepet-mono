class UpdateProductSlugs < ActiveRecord::Migration
  def change
    Product.all.each { |p| p.slug = nil; p.save! }
  end
end
