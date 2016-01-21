class AddStepStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :step_status, :string
  end
end
