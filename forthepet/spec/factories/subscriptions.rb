FactoryGirl.define do
  factory :subscription do
    user nil
frequency 1
variant nil
quantity 1
price "MyString"
last_order_on "MyString"
next_order_on "2017-01-10"
state "MyString"
  end

end
