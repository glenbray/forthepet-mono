class AddIsMasterToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :is_master, :boolean
  end
end
