class RemoveColumnFromVariantsAndProducts < ActiveRecord::Migration
  def change
    remove_column :products, :variant_id
    remove_column :variants, :name
  end
end
