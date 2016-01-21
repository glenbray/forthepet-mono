class DropColumnFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :finishes_on, :datetime
  end
end
