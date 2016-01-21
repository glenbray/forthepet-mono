class UpdateCategoryRelation < ActiveRecord::Migration
  def change
    add_column :items, :category_id, :integer
    add_index :items, :category_id
    remove_index :categories, :ancestry
    remove_column :categories, :ancestry
  end
end
