class Admin::CreateProductForm < Reform::Form
  model :product

  property :name, validates: { presence: true }
  property :description, validates: { presence: true }
  property :brand_id, validates: { presence: true }

  property :master_variant do
    property :sku
    property :price, validates: { presence: true, numericality: true }
    property :original_price
    property :quantity, validates: { presence: true, numericality: true }
    property :weight, validates: { presence: true, numericality: true }
  end
end
