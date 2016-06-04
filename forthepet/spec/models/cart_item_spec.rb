require 'rails_helper'
describe CartItem, type: :model do

  let(:product) { FactoryGirl.create(:product) }

  it { is_expected.to belong_to :cart }
  it { is_expected.to belong_to :deal }
  it { is_expected.to belong_to :variant }

  describe '.total' do
    it 'should return correct total' do
      cart_item = CartItem.new(variant: product.master_variant, quantity: 1)
      expect(cart_item.total).to eq(product.master_variant.price)
    end

    it 'multiplies by quantity' do
      cart_item = CartItem.new(variant: product.master_variant, quantity: 2)
      expect(cart_item.total).to eq(product.master_variant.price * 2)
    end
  end

  describe '.inactive' do
    it 'updates is_active to false' do
      cart_item = CartItem.new(variant: product.master_variant, quantity: 2, is_active: true)
      expect {
        cart_item.inactive!
      }.to change { cart_item.is_active }.from(true).to(false)
    end
  end

end
