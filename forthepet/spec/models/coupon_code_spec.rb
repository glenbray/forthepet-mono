require 'rails_helper'

RSpec.describe CouponCode, type: :model do
  it { is_expected.to belong_to :coupon }
  it { is_expected.to have_many :orders }
end
