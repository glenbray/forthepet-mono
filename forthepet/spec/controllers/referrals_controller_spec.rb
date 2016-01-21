require 'rails_helper'

RSpec.describe ReferralsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns referral with users referral id' do
      sign_in(user)
      expected_url = referral_url(user.referral_id)
      get :index
      expect(assigns[:referral_url]).to eq(expected_url)
    end
  end

  describe 'GET #show' do

    let(:referral_id) { 'bc37252e6c654199a9c97d139a22b545' }

    it 'redirects to root path' do
      get :show, id: referral_id
      expect(response).to redirect_to(root_path)
    end

    context 'user signed in' do
      before :each do
        sign_in user
      end

      it 'updates user referral_id with id paramater' do
        allow(controller.current_user).to receive(:orders).and_return(double('Orders', 'zero?' => true))
        get :show, id: referral_id
        expect(controller.current_user.referred_by).to eq(user.email)
      end

      it 'should not update referral_id if user has orders' do
        allow(controller.current_user).to receive(:orders).and_return(double('Orders', 'zero?' => false))
        get :show, id: referral_id
        expect(controller.current_user.referred_by).to eq(nil)
      end
    end

    context 'user not signed in' do
      it 'stores id parameter into referral_id session' do
        get :show, id: referral_id
        expect(session[:referral_id]).to eq(referral_id)
      end
    end

  end

end
