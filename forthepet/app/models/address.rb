class Address < ActiveRecord::Base
  belongs_to :user

  attr_accessor :billing_is_shipping

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address1, presence: true
  validates :suburb, presence: true
  validates :state, presence: true
  validates :postcode, presence: true

  def address
    "#{address1} #{suburb} #{state} #{postcode}"
  end
end
