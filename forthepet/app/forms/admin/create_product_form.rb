class Admin::CreateProductForm < Reform::Form
  model :product

  property :name, validates: { presence: true }
  property :description, validates: { presence: true }
  property :brand

  property :master_variant do
    property :sku
    property :price, validates: { presence: true, numericality: true }
    property :quantity, validates: { presence: true, numericality: true }
  end

end
