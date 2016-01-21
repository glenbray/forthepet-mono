class AddIsActiveToProducts < ActiveRecord::Migration
  def change
    add_column :items, :is_active, :boolean
  end
end
