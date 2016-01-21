class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart
      t.belongs_to :user
      t.belongs_to :variant

      t.integer :quantity
      t.boolean :is_active

      t.timestamps
    end
  end
end
