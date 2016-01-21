class UserDiscounts < ActiveRecord::Migration
  def change
    create_table :user_discounts do |t|
      t.integer :user_id
      t.integer :discount_id
      t.boolean :applied
      t.timestamps
    end
  end
end
