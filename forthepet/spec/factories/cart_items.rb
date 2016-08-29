# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart_item do
    user_id 1
    variant_id 1
    quantity 1
    is_active true
  end
end
