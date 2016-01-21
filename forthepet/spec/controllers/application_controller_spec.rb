require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  describe '#after_sign_in_path_for' do
    describe 'referrals' do

      before :each do
        user = FactoryGirl.create(:user)
        sign_in user
      end

      it 'should update referring users referral' do
        referrer = FactoryGirl.create(:referrer_user)
        session[:referral_id] = referrer.referral_id

        current_user = controller.current_user
        controller.after_sign_in_path_for(current_user)

        expect(referrer.referrals.first.email).to eq('bob@jones.com')
      end

      it 'should update current_user referred_by field with referral users email' do
        referrer = FactoryGirl.create(:referrer_user)
        session[:referral_id] = referrer.referral_id

        current_user = controller.current_user
        controller.after_sign_in_path_for(current_user)

        expect(current_user.referred_by).to eq('referrer@email.com')
      end
    end

  end

end
