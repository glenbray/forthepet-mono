class AddDescriptionToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :description, :string
  end
end