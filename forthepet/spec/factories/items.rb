# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :item do
    name 'test test z'
  end

  factory :coupaw_item, class: 'Item' do
    name 'Cheese shaped cat scratcher'
    description 'Hi-Ho the derry-oh! Kitty will take the mouse and cheese with this multi-functional scratcher. You want your cat to sharpen her claws, just not on your nice furniture! Now she can scratch her own kind of furniture – a dog-shaped cardboard figure, in fact! Made by Imperial Cat, these are 100% recycled and an eco-friendly solution to keep your favorite feline healthy and happy.'
    status 'available'
    meta_description 'some description'
    permalink 'cheese-shaped-cat-scratcher'
    meta_keywords 'cheese cat kitten scratcher'
  end

  factory :create_item, class: 'Item' do
    name 'test-item'
  end

end
