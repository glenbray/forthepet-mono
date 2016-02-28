# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :product do
    brand 'some brand'
    name 'some name'
    permalink 'some-brand'

    after(:create) do |product|
      product.categories << FactoryGirl.create(:all)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :dog_product, class: Product do
    name 'doggy product'

    after(:create) do |product|
      product.categories << FactoryGirl.create(:dog)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :cat_product, class: Product do
    name 'cat product'

    after(:create) do |product|
      product.categories << FactoryGirl.create(:cat)
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.save
    end
  end

  factory :product_with_variants, class: Product do
    name 'prod with vars'

    after(:create) do |product|
      product.master_variant = FactoryGirl.create(:variant, product_id: product.id)
      product.variants.build(price: 22)
      product.variants.build(price: 45)
      product.variants.build(price: 88)
      product.save
    end
  end

end
