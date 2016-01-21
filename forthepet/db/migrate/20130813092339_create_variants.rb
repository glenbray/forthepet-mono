class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :product_id, null: false
      t.string :sku
      t.string :name
      t.decimal :price
      t.decimal :cost
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
