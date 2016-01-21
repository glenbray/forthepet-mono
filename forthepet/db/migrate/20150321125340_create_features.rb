class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :description
      t.references :product, index: true

      t.timestamps
    end
  end
end
