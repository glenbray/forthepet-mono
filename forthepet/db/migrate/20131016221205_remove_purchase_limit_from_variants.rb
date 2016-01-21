class RemovePurchaseLimitFromVariants < ActiveRecord::Migration
  def change
    remove_column :variants, :purchase_limit
  end
end
