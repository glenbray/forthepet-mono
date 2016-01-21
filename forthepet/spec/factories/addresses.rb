# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :address do
    first_name 'bob'
    last_name 'johnes'
    address1 'adddress 1'
    address2 'address 2'
    suburb 'somesuburb'
    state 'some state'
    postcode 1234
  end

  factory :billing, class: Address do
    first_name 'bob'
    last_name 'johnes'
    address1 'billing adddress 1'
    address2 'billing address 2'
    suburb 'billing suburb'
    state 'billing state'
    postcode 1234
  end

  factory :shipping, class: Address do
    first_name 'bob'
    last_name 'johnes'
    address1 'shipping address 1'
    address2 'shipping address 2'
    suburb 'shipping suburb'
    state 'shipping state'
    postcode 1234
  end

end
