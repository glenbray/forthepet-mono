class RenameIsactiveProducts < ActiveRecord::Migration
  def change
    rename_column :products, :isactive, :is_active
  end
end
