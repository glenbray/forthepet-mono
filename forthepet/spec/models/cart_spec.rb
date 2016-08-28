require 'rails_helper'

describe Cart, type: :model do

  let(:cart) { Cart.create }

  def create_cart_item(params)
    CartItem.new(variant_id: params[:variant_id], quantity: params[:quantity])
  end

  before :each do
    @product = FactoryGirl.create(:product)

    params = { variant_id: @product.master_variant.id, quantity: 1 }
    @cart_item = create_cart_item(params)
  end

  describe '.add_item' do
    it 'adds cart item to cart' do
      expect {
        cart.add_item(@cart_item)
      }.to change(cart.cart_items, :count).by(1)
    end

    it 'updates quantity if cart item already exists' do
      2.times { cart.add_item(@cart_item) }
      expect(cart.cart_items.first.quantity).to eq(2)
    end

    it 'does not insert a new record into cart item if cart item exists' do
      2.times { cart.add_item(@cart_item) }
      expect(cart.cart_items.count).to be(1)
    end

    it 'activates cart item' do
      cart.add_item(@cart_item)
      expect(@cart_item.is_active).to be_truthy
    end
  end

  describe '.total' do
    it 'returns 0 if no cart items' do
      expect(cart.total).to eq(0)
    end

    it 'returns the total for a cart item' do
      cart.add_item(@cart_item)
      expect(cart.total).to eq(@product.master_variant.price)
    end

    it 'returns correct total for cart items with quantity' do
      cart.add_item(@cart_item)
      cart.add_item(@cart_item)
      expect(cart.total).to eq(@product.master_variant.price * 2)
    end

    it 'returns correct total with multiple cart items and differing quantities' do
      product = FactoryGirl.create(:product_with_variants)
      variant_ids = product.variants.map(&:id)

      params1 = { variant_id: variant_ids[0], quantity: 1 }
      params2 = { variant_id: variant_ids[1], quantity: 2 }

      item1 = create_cart_item(params1)
      item2 = create_cart_item(params2)
      cart.add_item(item1)
      cart.add_item(item2)

      expected_total = item1.total + item2.total
      expect(cart.total).to eq(expected_total)
    end
  end

  describe '.cart_quantity' do
    it 'returns 0 if there is no cart items' do
      expect(cart.cart_quantity).to eq(0)
    end

    it 'returns the quantity of cart items' do
      cart.add_item(@cart_item)
      expect(cart.cart_quantity).to eq(1)
    end

    it 'correct quantity if an individual item has a quantity greater than 1' do
      cart.add_item(@cart_item)
      cart.add_item(@cart_item)
      expect(cart.cart_quantity).to eq(2)
    end
  end

end
