# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    first_name 'Bob'
    last_name 'Johnes'
    email 'bob@jones.com'
    password 'password'

    after(:create) do |user|
      user.shipping = FactoryGirl.create(:shipping, user_id: user.id)
      user.billing = FactoryGirl.create(:billing, user_id: user.id)
    end
  end

  factory :referrer_user, class: User do
    first_name 'Referrer'
    email 'referrer@email.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
    # referral_id '3D4C6E4FA95C4FE69E5073A869BC51FA'
  end

end
