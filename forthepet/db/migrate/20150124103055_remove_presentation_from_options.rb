class RemovePresentationFromOptions < ActiveRecord::Migration
  def change
    remove_column :options, :presentation
  end
end
