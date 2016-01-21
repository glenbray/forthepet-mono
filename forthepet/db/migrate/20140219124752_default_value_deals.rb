class DefaultValueDeals < ActiveRecord::Migration
  def change
    change_column :deals, :is_active, :boolean, default: false
    change_column :items, :is_active, :boolean, default: false
  end
end
