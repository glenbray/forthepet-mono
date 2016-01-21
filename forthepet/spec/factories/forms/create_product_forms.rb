# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :create_product_form, class: Admin::CreateProductForm do
    name 'Some name'
    brand 'Some brand'
    description 'some description'
    sku 'somesku'
    price 22
  end
end
