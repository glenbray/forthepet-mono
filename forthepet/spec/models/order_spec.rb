require 'rails_helper'

describe Order, type: :model do
  it { is_expected.to have_many :order_items }
  it { is_expected.to belong_to :user }

  let(:order) { Order.create }
  let(:order_item) { order.order_items.build }

  describe 'order states' do
    it 'should have state session on create' do
      expect(order.aasm_state).to eq('session')
    end
  end

  describe '#has_active_deals?' do
    it 'returns true if the order contains active deals' do
      order_item = order.order_items.build
      order_item.deal = Deal.create(ends_on: 1.day.from_now)
      order_item.save

      expect(order.has_active_deals?).to be_truthy
    end

    it 'returns false if the order does not contain active deals'do
      order_item.deal = Deal.create(ends_on: 1.day.ago)
      order_item.save

      expect(order.has_active_deals?).to be_falsey
    end
  end

  describe '#ship_it' do
    it 'updates orders state to shipped' do
      order_item.deal = Deal.create(ends_on: 1.day.ago)
      order_item.save
      order.paid!
      order.ship_it
      expect(order.aasm_state).to eq('shipped')
    end

    it 'updates order items state to shipped' do
      order_item.deal = Deal.create(ends_on: 1.day.ago)
      order_item.save
      order.paid!
      order.ship_it
      expect(order_item.reload.aasm_state).to eq('shipped')
    end

    it 'returns false if an item cannot be shipped' do
      order_item.deal = Deal.create(ends_on: 1.day.from_now)
      order_item.save

      expect(order.ship_it).to be_falsey
    end

  end

end
