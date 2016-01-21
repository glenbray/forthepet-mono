class CreateTableProductProperties < ActiveRecord::Migration
  def change
    create_table :products_properties do |t|

      t.belongs_to :product
      t.belongs_to :property

    end
  end
end
