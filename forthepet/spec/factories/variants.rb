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

end
