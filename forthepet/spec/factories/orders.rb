# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :order do
    total_amount '9.99'
    quantity ''
    special_instructions 'MyString'
    coupon_code 'MyString'
    use_billing false
  end

  factory :billing_details, class: Order do
    email 'test@asdf.com'
    billing_first_name 'Bob'
    billing_last_name 'Carr'
    billing_address1 'some address'
    billing_suburb 'suburb'
    billing_state 'state'
    billing_postcode 1111
    billing_mobile 1_212_121_212
    billing_phone 211_112_111
  end

end
