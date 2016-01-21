class RemoveOldProductColumns < ActiveRecord::Migration
  def change
    remove_column :products, :name
    remove_column :products, :description
    remove_column :products, :price
    remove_column :products, :is_active
    remove_column :products, :meta_description
    remove_column :products, :permalink
    remove_column :products, :meta_keywords
    remove_column :products, :slug

    remove_column :deals, :start
    remove_column :deals, :end

    remove_column :photos, :product_id
  end
end
