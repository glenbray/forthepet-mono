class AddNotesToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :notes, :string
  end
end
