class RenameCompanyInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :company, :billing_company
    add_column :orders, :shipping_company, :string
  end
end
