class AddTransactionNoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :transaction_no, :string
  end
end
