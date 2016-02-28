# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :all, class: Category do
    name 'All'
  end

  factory :dog, class: Category do
    name 'Dog'

    after(:create) do |category|
      category.children.create(name: 'Food')
      category.children.create(name: 'Flea & Worming')
      category.children.create(name: 'Litter')
      category.children.create(name: 'Toys')
      category.children.create(name: 'Treats')
      category.children.create(name: 'Collars & Leads')
      category.children.create(name: 'Accessories')
      category.children.create(name: 'Clean up')
      category.children.create(name: 'Beds')
      category.children.create(name: 'Grooming')
      category.children.create(name: 'Health')
    end
  end

  factory :cat, class: Category do
    name 'Cat'
  end

  factory :misc, class: Category do
    name 'Miscellaneous'
  end
end
