class CreateCategoriesProductsTable < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :category_id, index: true
      t.integer :product_id, index: true
      t.timestamps
    end
  end
end
