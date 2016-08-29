require 'rails_helper'

describe CalculatePostage do
  describe 'calculate' do
    subject { CalculatePostage.new(cart, postcode) }

    context 'cart contains items with free postage' do
      let(:weight) { 10 }
      let(:postcode) { 7000 }

      context 'with items only with free postage' do
        let(:cart) do
          cart = Cart.create
          variant = FactoryGirl.create(:variant_free_postage)
          cart_item = CartItem.create(variant: variant, quantity: 1)
          cart.add_item(cart_item)
          cart
        end

        it 'returns 0' do
          expect(subject.calculate.cost).to eq(0)
        end
      end

      context 'with items that are not free postage' do
        let(:cart) do
          cart = Cart.create
          free_variant = FactoryGirl.create(:variant_free_postage)
          variant = FactoryGirl.create(:variant, product: FactoryGirl.create(:product))
          cart_item_1 = CartItem.create(variant: free_variant, quantity: 1)
          cart_item_2 = CartItem.create(variant: variant, quantity: 1)
          cart.add_item(cart_item_1)
          cart.add_item(cart_item_2)
          cart
        end

        it 'does not return 0' do
          expect(subject.calculate.cost).to_not eq(0)
        end
      end
    end
  end
end
