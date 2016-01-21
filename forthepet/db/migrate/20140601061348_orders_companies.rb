class OrdersCompanies < ActiveRecord::Migration
  def change
    add_column :orders, :billing_company, :string
    add_column :orders, :shipping_company, :string
  end
end
