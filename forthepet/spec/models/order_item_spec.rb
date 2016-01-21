require 'rails_helper'

describe OrderItem, type: :model do
  it { is_expected.to belong_to :order }
  it { is_expected.to belong_to :deal }
  it { is_expected.to belong_to :variant }
end
