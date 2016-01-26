class UpdateProductPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :description, :string
    add_column :variants, :photo_id, :integer
    add_index :variants, :photo_id
  end
end
