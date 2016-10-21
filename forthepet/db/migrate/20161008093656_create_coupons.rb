class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :title
      t.string :code
      t.string :description
      t.decimal :amount
      t.decimal :percent
      t.date :starts_at
      t.decimal :expires_at

      t.timestamps null: false
    end
    add_index :coupons, :code, unique: true
  end
end
