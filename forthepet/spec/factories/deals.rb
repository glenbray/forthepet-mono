# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :deal do
    name 'random deal'
    available_on 2.days.ago
    ends_on 7.days.from_now
    is_active = true

    after(:create) do |deal|
      deal.product = FactoryGirl.create(:product)
      variant = deal.product.master_variant
      deal.deal_prices.build(variant_id: variant.id, price: 33)
      deal.save
    end
  end

  factory :ended_deal, class: Deal do
    name 'ended deal'
    available_on 10.days.ago
    ends_on 2.days.ago

    after(:create) do |deal|
      deal.product = FactoryGirl.create(:product)
      variant = deal.product.master_variant
      deal.deal_prices.build(price: 33, variant_id: variant.id)
      deal.save
    end
  end

  factory :dog_deal, class: Deal do
    name 'dog deal'
    available_on 10.days.ago
    ends_on 8.days.from_now

    after(:create) do |deal|
      deal.product = FactoryGirl.create(:dog_product)
      deal.save
    end
  end

  factory :cat_deal, class: Deal do
    name 'cat deal'
    available_on 10.days.ago
    ends_on 10.days.from_now

    after(:create) do |deal|
      deal.product = FactoryGirl.create(:cat_product)
      deal.save
    end
  end

  factory :deal_with_variants, class: Deal do
    name 'deal with vars'
    available_on 1.days.ago
    ends_on 2.days.from_now

    after(:create) do |deal|
      deal.product = product = FactoryGirl.create(:product_with_variants)
      deal.product.variants.each do |v|
        discount = v.price * 0.8
        deal.deal_prices.build(variant_id: v.id, price: discount, percentage_saved: (discount / v.price * 100))
      end
      deal.save
    end
  end

end
