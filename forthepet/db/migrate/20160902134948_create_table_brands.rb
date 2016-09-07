class CreateTableBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
    end

    add_index :brands, :name, unique: true
    add_column :products, :brand_id, :integer

    add_index :products, :brand_id

    Product.all.each do |p|
      next if p.brand.blank?

      brand = Brand.find_or_create_by(name: p.brand.strip)
      p.brand_id = brand.id
      p.save
    end

    remove_column :products, :brand
  end
end
