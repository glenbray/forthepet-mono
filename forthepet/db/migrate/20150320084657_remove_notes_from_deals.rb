class RemoveNotesFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :notes
  end
end
