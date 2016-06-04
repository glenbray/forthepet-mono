class SetActiveState < ActiveRecord::Migration
  def change
    add_column :products, :is_active_tmp, :boolean, default: true

    Product.all.each { |p| p.update(is_active_tmp: false) }
    Deal.active.each { |deal| deal.product.update(is_active_tmp: true) }
    remove_column :products, :is_active
    rename_column :products, :is_active_tmp, :is_active
  end
end
