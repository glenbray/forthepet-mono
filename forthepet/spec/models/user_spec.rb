require 'rails_helper'

describe User, type: :model do
  it { is_expected.to belong_to(:shipping).class_name('Address').with_foreign_key('shipping_id') }
  it { is_expected.to belong_to(:billing).class_name('Address').with_foreign_key('billing_id') }
  it { is_expected.to have_many :carts }
  it { is_expected.to have_many :orders }
  it { is_expected.to have_many :referrals }
  it { is_expected.to have_many(:discounts).through(:user_discounts) }

  it 'should have a method to return full name' do
    user = FactoryGirl.build(:user)
    expect(user.full_name).to eq('Bob Johnes')
  end

  describe '.orders' do
    it 'returns orders that do not have the aasm_status of session' do
      user =  FactoryGirl.create(:user)
      user.orders.create
      expect(user.orders.count).to eq(0)
    end
  end

  describe '.before_save' do
    let(:referral_id) { 'bc37252e6c654199a9c97d139a22b545' }

    it 'updates users referral id' do
      user = FactoryGirl.create(:user)
      expect(user.referral_id).to eq(referral_id)
    end
  end

end
