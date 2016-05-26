class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_many :order_items

  scope :non_session_orders, -> { where.not(aasm_state: 'session') }
  scope :pending_orders, -> { includes(order_items: [:deal]).where(aasm_state: 'pending') }
  scope :shipped_orders, -> { where(aasm_state: 'shipped' )}

  aasm do
    state :session, initial: true
    state :pending
    state :shipped

    event :paid do
      transitions from: :session, to: :pending
    end

    event :ship do
      transitions from: :pending, to: :shipped
    end
  end

  def is_details_step?
    step_status == :details
  end

  def is_payment_step?
    step_status == :payment
  end

  def is_summary_step?
    step_status == :summary
  end

  def shipping_is_billing!
    tap do |s|
      s.shipping_firstname = s.billing_firstname
      s.shipping_surname = s.billing_surname
      s.shipping_address1 = s.billing_address1
      s.shipping_address2 = s.billing_address2
      s.shipping_company = s.billing_company
      s.shipping_suburb = s.billing_suburb
      s.shipping_state = s.billing_state
      s.shipping_postcode = s.billing_postcode
      s.shipping_phone = s.billing_phone
      s.shipping_mobile = s.billing_mobile
    end
    self.save!
  end

  def order_items_total
    order_items.sum(&:total)
  end

  def order_item_quantity
    order_items.pluck(:quantity).sum
  end

  def ship_it
    order_items.update_all(aasm_state: 'shipped')
    ship!
  end

end
