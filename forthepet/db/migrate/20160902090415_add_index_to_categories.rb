class AddIndexToCategories < ActiveRecord::Migration
  def change
    remove_index :categories, :name
    add_index :categories, :name, unique: true
  end
end
