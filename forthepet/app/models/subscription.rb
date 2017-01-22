class Subscription < ActiveRecord::Base
  include RepeatDeliverable

  SHARED_ATTRIBUTES_WITH_ORDERS = [
    :email,
    :billing_first_name,
    :billing_last_name,
    :billing_address1,
    :billing_suburb,
    :billing_state,
    :billing_postcode,
    :shipping_first_name,
    :shipping_last_name,
    :shipping_address1,
    :shipping_suburb,
    :shipping_state,
    :shipping_postcode,
    :billing_company,
    :shipping_company,
    :billing_address2,
    :billing_mobile,
    :billing_phone,
    :shipping_address2,
    :shipping_mobile,
    :shipping_phone,
    :postage
  ]

  belongs_to :payment_method, required: true
  belongs_to :user, required: true
  belongs_to :variant, required: true
  has_many :orders

  include AASM

  aasm do
    state :active, initial: true
    state :paused
    state :cancelled

    event :pause do
      after { update! next_order_on: nil }
      transitions from: :active, to: :paused
    end

    event :resume do
      after { update! next_order_on: Date.current + 1.day }
      transitions from: :paused, to: :active
    end

    event :cancel do
      after { update! end_at: Time.current, next_order_on: nil }
      transitions from: [:active, :paused], to: :cancelled
    end
  end

  def create_order
    return unless active?
    return unless Date.current == next_order_on
    # prevent duplicate orders
    return if orders.detect{|o| o.created_at.to_date == Date.current}

    order = orders.new slice(*SHARED_ATTRIBUTES_WITH_ORDERS)

    order.order_items.build quantity: quantity, variant_id: variant_id,
      price: variant.price

    order.total = order.order_items.first.total + order.postage

    order.save!
    update last_order_on: Date.current, next_order_on: next_order_on + frequency_to_time

    result = Braintree::Transaction.sale(
      amount: order.total,
      payment_method_token: payment_method.braintree_token,
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      order.transaction_no = result.transaction.id
      order.purchased_at = result.transaction.created_at
      order.save!
      order.order_items.first.pay!
      order.paid!
    end

    CustomerMailer.delay.customer_invoice(order)
    NewOrderMailer.delay.new_order
  end

  def shipping_full_name
    "#{shipping_first_name} #{shipping_last_name}"
  end

  def billing_full_name
    "#{billing_first_name} #{billing_last_name}"
  end

  def billing_address
    "#{billing_address1} #{billing_suburb} #{billing_state} #{billing_postcode}"
  end

  def shipping_address
    "#{shipping_address1} #{shipping_suburb} #{shipping_state} #{shipping_postcode}"
  end

  class << self
    def create_orders
      find_each do |subscription|
        subscription.create_order rescue nil
      end
    end
  end
end
