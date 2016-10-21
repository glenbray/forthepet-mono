require 'rails_helper'

describe Order, type: :model do
  it { is_expected.to have_many :order_items }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :coupon_code }

  let(:order) { Order.create }
  let(:order_item) { order.order_items.build }

  describe 'order states' do
    it 'should have state session on create' do
      expect(order.aasm_state).to eq('session')
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
  end
end
