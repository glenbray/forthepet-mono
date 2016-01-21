class RemovePhotoIdFromVariants < ActiveRecord::Migration
  def change
    remove_column :variants, :photo_id
  end
end
