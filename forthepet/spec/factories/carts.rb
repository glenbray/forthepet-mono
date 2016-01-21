# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do
    after :create do |cart|
      cart.variant = FactoryGirl.create(:variant)
    end
  end
end
