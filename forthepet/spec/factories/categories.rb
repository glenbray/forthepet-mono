# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :all, class: Category do
    name 'All'
  end

  factory :dog, class: Category do
    name 'Dog'
  end

  factory :cat, class: Category do
    name 'Cat'
  end

  factory :misc, class: Category do
    name 'Miscellaneous'
  end
end
