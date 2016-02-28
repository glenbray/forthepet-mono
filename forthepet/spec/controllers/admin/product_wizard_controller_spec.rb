require 'rails_helper'

RSpec.describe Admin::ProductWizardController, :type => :controller do

  describe 'GET show' do

    before :each do
      admin = FactoryGirl.create(:admin)
      sign_in admin
    end

    describe 'category step' do
      it 'renders category template' do
        get :show, id: 'category'
        expect(response).to render_template('category')
      end
    end

    describe 'supplier step' do
      it 'renders supplier page' do
        get :show, id: 'supplier'
        expect(response).to render_template('supplier')
      end
    end

    describe 'product step' do
      it 'renders product page' do
        get :show, id: 'product'
        expect(response).to render_template('product')
      end
    end

    describe 'image step' do
      it 'renders image page' do
        get :show, id: 'image'
        expect(response).to render_template('image')
      end
    end

  end

end
