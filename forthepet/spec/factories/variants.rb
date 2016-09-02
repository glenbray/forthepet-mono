# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variant do
    quantity '100'
    is_master true
    sku 'test'
    price 50.0
    original_price 148
    cost 10
    weight 20
  end

  factory :variant_free_postage, class: Variant do
    quantity '100'
    is_master false
    sku 'free-postage'
    price 20.0
    original_price 55
    cost 0
    weight 100
    free_postage true
    before(:create) do |v|
      v.product = FactoryGirl.create(:product)
    end
  end
end
