# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fine_print do
    description 'some fine print'
    is_default true
  end

  factory :deal_fine_print, class: FinePrint do
    description 'another fine print'
    is_default true
  end

  factory :non_default_fine_print, class: FinePrint do
    description 'non default fine print'
    is_default false
  end
end
