class AddIndexToDealFinePrints < ActiveRecord::Migration
  def change
    add_index :deal_fine_prints, [:deal_id, :fine_print_id]
  end
end
