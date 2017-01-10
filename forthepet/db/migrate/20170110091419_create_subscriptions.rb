class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :variant, index: true, foreign_key: true
      t.references :payment_method, index: true, foreign_key: true
      t.integer :frequency
      t.integer :quantity
      t.decimal :postage, precision: 10, scale: 2
      t.datetime :start_at
      t.datetime :end_at
      t.date :last_order_on
      t.date :next_order_on
      t.string :aasm_state

      t.string :email
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_address1
      t.string :billing_suburb
      t.string :billing_state
      t.integer :billing_postcode
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address1
      t.string :shipping_suburb
      t.string :shipping_state
      t.integer :shipping_postcode
      t.string :billing_company
      t.string :shipping_company
      t.string :billing_address2
      t.string :billing_mobile
      t.string :billing_phone
      t.string :shipping_address2
      t.string :shipping_mobile
      t.string :shipping_phone

      t.timestamps null: false
    end
  end
end
