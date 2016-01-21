class DropProductsOptions < ActiveRecord::Migration
  def change
    drop_table :products_options

    create_table :options_products do |t|
      t.belongs_to :product
      t.belongs_to :option
    end
  end
end
