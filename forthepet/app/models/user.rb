class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, authentication_keys: [:email]

  belongs_to :shipping, class_name: 'Address', foreign_key: 'shipping_id'
  belongs_to :billing, class_name: 'Address', foreign_key: 'billing_id'

  has_many :carts
  has_many :credits
  has_many :orders, -> { where "aasm_state != ?", :session }
  has_many :referrals

  has_many :user_discounts
  has_many :discounts, through: :user_discounts

  before_save :update_referral_id

  def shipping_address
    shipping ? shipping.address : ''
  end

  def has_shipping?
    !!shipping
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # def credit!(amount, reason)
  #   credit = Credit.new
  #   credit.user_id = id
  #   credit.amount = amount
  #   credit.reason = reason
  #   credit.save
  # end

  def first_order?
    orders_count <= 1
  end

  def orders_count
    orders.count
  end

  private

  def update_referral_id
    self.referral_id = Digest::MD5.hexdigest(self.email)
  end
end
