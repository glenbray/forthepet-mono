class RemoveShortDescriptionFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :short_description
  end
end
