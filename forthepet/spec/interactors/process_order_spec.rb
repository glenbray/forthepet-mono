require 'rails_helper'

describe ProcessOrder do

  let(:cart) { Cart.create }
  let(:order) { Order.create(email: 'test@test.com') }

  def create_cart_item(params)
    cart_item = CartItem.new(variant_id: params[:variant_id], quantity: params[:quantity])
    cart_item.deal_id = params[:deal_id]
    cart_item
  end

  describe '#process' do

    before :each do
      Delayed::Worker.delay_jobs = false
      deal = FactoryGirl.create(:deal)
      product = deal.product

      params = { variant_id: product.master_variant.id, quantity: 1, deal_id: deal.id }
      cart_item = create_cart_item(params)
      cart.add_item(cart_item)
    end

    it 'saves cart total to order total' do
      allow(cart).to receive(:total) { 100.42 }
      ProcessOrder.new(order, cart).process
      expect(order.total).to eq(100.42)
    end

    it 'saves cart items to order' do
      process_order = ProcessOrder.new(order, cart)
      expect {
        process_order.process
      }.to change(OrderItem, :count).by(1)
    end

    it 'creates an order item with correct attributes' do
      process_order = ProcessOrder.new(order, cart)
      process_order.process
      order_item = order.order_items.first
      cart_item = cart.cart_items.first

      expect(order_item.deal_id).to eq(cart_item.deal_id)
      expect(order_item.quantity).to eq(cart_item.quantity)
      expect(order_item.variant_id).to eq(cart_item.variant_id)
      expect(order_item.price).to eq(cart_item.deal.deal_prices.first.price)
    end

    it 'updates each item state from pending to paid' do
      process_order = ProcessOrder.new(order, cart)
      process_order.process

      order.order_items.each do |order_item|
        expect(order_item.aasm_state).to eq('paid')
      end
    end

    it 'updates order state from session to pending' do
      process_order = ProcessOrder.new(order, cart)
      process_order.process
      expect(order.aasm_state).to eq('pending')
    end

    it 'updates orders purchased_at with current time' do
      process_order = ProcessOrder.new(order, cart)

      expect {
        process_order.process
      }.to change{order.reload.purchased_at}.from(nil)
    end

    it 'sends customer an invoice email' do
      ProcessOrder.new(order, cart).process
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    context 'user referrals' do
      let(:user) { FactoryGirl.create(:user) }
      let(:referrer) { FactoryGirl.create(:referrer_user) }

      it 'adds current user to referring users referrals' do
        user.referred_by = referrer.email
        order.user = user

        process_order = ProcessOrder.new(order, cart)
        process_order.process

        expect(referrer.referrals.count).to eq(1)
        expect(referrer.referrals.first.email).to eq(user.email)
      end

      it 'does not add referral if user has orders' do
        allow(user.orders).to receive(:count) { 2 }
        order.user = user

        process_order = ProcessOrder.new(order, cart)
        process_order.process
        expect(referrer.referrals.count).to eq(0)
      end

      it 'applies discount to referring user' do
        Discount.create(description: 'Referral Discount', amount: 5)
        user.referred_by = referrer.email
        order.user = user

        process_order = ProcessOrder.new(order, cart)
        process_order.process

        expect(referrer.user_discounts.count).to eq(1)
      end

    end

  end

end
