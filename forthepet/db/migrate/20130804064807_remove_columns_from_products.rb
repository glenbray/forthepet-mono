class RemoveColumnsFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :available_on, :datetime
  end
end
