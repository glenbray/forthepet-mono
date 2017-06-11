class AddCourierToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :courier, :string
  end
end
