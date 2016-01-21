require 'rails_helper'

RSpec.describe Admin::ProductController, type: :controller do
  before :each do
    admin = FactoryGirl.create(:admin)
    sign_in admin
  end

  describe 'GET #index' do
    it 'products collection should not contain products that are not yet active' do
      p1 = Product.create(is_active: true)
      p2 = Product.create(is_active: false)

      get :index
      expect(assigns(:products)).to match_array([p1])
    end
  end

end
