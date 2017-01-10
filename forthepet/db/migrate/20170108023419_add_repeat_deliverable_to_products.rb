class AddRepeatDeliverableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :repeat_deliverable, :boolean, default: true
  end
end
