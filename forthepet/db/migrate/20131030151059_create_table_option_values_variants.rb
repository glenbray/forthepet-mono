class CreateTableOptionValuesVariants < ActiveRecord::Migration
  def change
    create_table :option_values_variants do |t|
      t.integer :option_value_id
      t.integer :variant_id
    end
    add_index :option_values_variants, :option_value_id
    add_index :option_values_variants, :variant_id
    add_index :option_values_variants, [:option_value_id, :variant_id], unique: true
    remove_column :variants, :option_value_id
  end
end
