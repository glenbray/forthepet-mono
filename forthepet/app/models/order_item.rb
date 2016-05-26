class OrderItem < ActiveRecord::Base
  include AASM

  belongs_to :order, counter_cache: :quantity
  belongs_to :deal
  belongs_to :variant

  scope :pending_orders_group_by_deals, -> { joins(:deal).where(order_id: Order.pending_orders.pluck(:id)).group_by(&:deal_id) }

  def self.total
    sum("quantity * price")
  end

  aasm do
    state :pending, initial: true
    state :paid
    state :supplier_notified
    state :preparing
    state :shipped

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :notify_supplier do
      transitions from: :paid, to: :supplier_notified
    end

    event :received do
      transitions from: [:paid, :supplier_notified], to: :preparing
    end

    event :shipping do
      transitions from: :preparing, to: :shipped
    end
  end

  def total
    @total ||= quantity * price
  end

end
