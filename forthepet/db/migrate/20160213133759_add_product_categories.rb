class AddProductCategories < ActiveRecord::Migration
  def change
    remove_column :products, :category_id

    create_table :categories_products, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :category, index: true
    end
  end
end
