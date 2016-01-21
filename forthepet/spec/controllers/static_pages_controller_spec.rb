require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #checkout-payment-process' do
    it 'renders checkout_payment_process template' do
      get 'checkout_payment_process'
      expect(response).to render_template(:checkout_payment_process)
    end

    it 'renders privacy_policy template' do
      get 'privacy_policy'
      expect(response).to render_template(:privacy_policy)
    end

    it 'renders return_policy template' do
      get 'return_policy'
      expect(response).to render_template(:return_policy)
    end

    it 'renders how_it_works template' do
      get 'how_it_works'
      expect(response).to render_template(:how_it_works)
    end
  end

end
