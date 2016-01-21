class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
