class AddOptionValueIdToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :option_value_id, :integer
    add_index :variants, :option_value_id
  end
end
