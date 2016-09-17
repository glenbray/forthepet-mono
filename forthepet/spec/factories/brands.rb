# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brand do
    name 'brand'
  end

  factory :dog_brand, class: Brand do
    name 'dog brand'
  end

  factory :cat_brand, class: Brand do
    name 'cat brand'
  end

  factory :product_with_variants_brand, class: Brand do
    name 'product variant brand'
  end
end
