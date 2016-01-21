class AddIndexToDeals < ActiveRecord::Migration
  def change
    add_index :deals, :available_on
    add_index :deals, :ends_on
  end
end
