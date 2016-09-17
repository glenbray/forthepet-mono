# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier do
    name 'MyString'
    phone 'MyString'
    fax 'MyString'
    mobile 'MyString'
    email 'MyString'
  end

  factory :apple_supplier, class: Supplier do
  	name 'Apple Factory'
  end

  factory :orange_supplier, class: Supplier do
  	name 'Orange Facilities'
  end

  factory :mango_supplier, class: Supplier do
  	name 'Mango Limited'
  end

end
