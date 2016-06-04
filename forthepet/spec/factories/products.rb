# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :product do
    brand 'some brand'
    name 'some name'
    permalink 'some-brand'

    after(:create) do |product|
      product.category = FactoryGirl.create(:all)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :dog_product, class: Product do
    name 'doggy product'

    after(:create) do |product|
      product.category = FactoryGirl.create(:dog)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :cat_product, class: Product do
    name 'cat product'

    after(:create) do |product|
      product.category = FactoryGirl.create(:cat)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :product_with_variants, class: Product do
    name 'prod with vars'

    after(:create) do |product|
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.variants.build(price: 22, original_price: 30)
      product.variants.build(price: 45, original_price: 73)
      product.variants.build(price: 88, original_price: 120)
      product.save
    end
  end

end
