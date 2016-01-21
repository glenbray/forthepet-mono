# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :variant do
    quantity '100'
    is_master true
    sku 'test'
    price 50.0
    cost 10
  end

end
