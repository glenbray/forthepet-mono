class CreateFinePrints < ActiveRecord::Migration
  def change
    create_table :fine_prints do |t|
      t.text :description
      t.boolean :is_default
      t.timestamps
    end

    create_table :deal_fine_prints do |t|
      t.belongs_to :deal
      t.belongs_to :fine_print
    end
  end
end
