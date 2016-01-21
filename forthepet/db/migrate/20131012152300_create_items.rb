class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :status
      t.string :meta_description
      t.string :permalink
      t.string :meta_keywords
      t.integer :itemable_id
      t.string :itemable_type
      t.string :slug, unique: true
      t.timestamps
    end

    add_index :items, [:itemable_id, :itemable_type]
  end
end
