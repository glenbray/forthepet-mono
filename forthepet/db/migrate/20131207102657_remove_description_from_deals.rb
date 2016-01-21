class RemoveDescriptionFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :description
    remove_column :deals, :supplier_id
  end
end
