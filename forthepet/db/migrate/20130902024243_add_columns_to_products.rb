class AddColumnsToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :height
    remove_column :products, :width
    remove_column :products, :depth
    remove_column :products, :weight

    add_column :variants, :height, :decimal
    add_column :variants, :width, :decimal
    add_column :variants, :depth, :decimal
    add_column :variants, :weight, :decimal
  end
end
