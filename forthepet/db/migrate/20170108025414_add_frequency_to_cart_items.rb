class AddFrequencyToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :frequency, :integer
  end
end
