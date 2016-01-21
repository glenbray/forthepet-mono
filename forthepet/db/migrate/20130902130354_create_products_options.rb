class CreateProductsOptions < ActiveRecord::Migration
  def change
    create_table :products_options do |t|
      t.belongs_to :product
      t.belongs_to :option
    end

    create_table :variants_options do |t|
      t.belongs_to :variant
      t.belongs_to :option_value
    end
  end
end
