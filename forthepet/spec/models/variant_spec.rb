require 'rails_helper'

describe Variant, type: :model do

  it 'should not be valid without a price' do
    expect(Variant.new(price: nil)).to have(1).errors_on(:price)
  end

  it 'should not be valid without is_master' do
    expect(Variant.new(is_master: nil)).to have(1).errors_on(:is_master)
  end

  it { is_expected.to belong_to(:product) }
  it { is_expected.to have_many(:cart_items) }
end
