class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.belongs_to :option
      t.string :name
      t.string :display
      t.timestamps
    end
  end
end
