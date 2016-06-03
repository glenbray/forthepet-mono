# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email 'test@admin.com'
    password 'password'
    id 1
  end
end
