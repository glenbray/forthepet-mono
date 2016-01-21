class MergeItemsTableWithProducts < ActiveRecord::Migration
  def change
    add_column :products, :name, :string
    add_column :products, :description, :string
    add_column :products, :status, :boolean
    add_column :products, :meta_description, :string
    add_column :products, :permalink, :string
    add_column :products, :slug, :string
    add_column :products, :is_active, :string
    add_column :products, :category_id, :integer

    add_index :products, :supplier_id
    add_index :products, :category_id

    remove_column :items, :itemable_id
    remove_column :items, :itemable_type
    remove_column :cart_items, :supplier_id

    add_column :deals, :product_id, :integer
    add_index :deals, :product_id
    remove_column :deals, :item_id

    drop_table :items
  end
end
