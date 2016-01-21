class AddPurchaseLimitToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :purchase_limit, :integer
  end
end
