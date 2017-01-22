class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions

  def braintree
    @braintree ||= Braintree::PaymentMethod.find braintree_token
  end

  def payment_type
    case braintree
    when Braintree::PayPalAccount
      :paypal
    when Braintree::CreditCard
      :card
    else
      :unknown
    end
  end
end
