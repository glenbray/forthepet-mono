class AddColumnsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :available_on, :datetime
    add_column :deals, :ends_on, :datetime
  end
end
