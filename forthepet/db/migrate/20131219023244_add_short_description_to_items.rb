class AddShortDescriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :short_description, :string
  end
end
