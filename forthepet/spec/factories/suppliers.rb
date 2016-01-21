# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier do
    name 'MyString'
    phone 'MyString'
    fax 'MyString'
    mobile 'MyString'
    email 'MyString'
  end

  factory :apple, class: Supplier do
  	name 'Apple Factory'
  end

  factory :orange, class: Supplier do
  	name 'Orange Facilities'
  end

  factory :mango, class: Supplier do
  	name 'Mango Limited'
  end

end
