class AddPictureToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :picture, :string
  end
end
