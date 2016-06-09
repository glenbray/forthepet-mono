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

      it 'updates product category id' do
        category = FactoryGirl.create(:dog)
        product = Product.create
        session[:product_id] = product.id

        put :update, id: 'category', product: { category: category.id }

        expect(assigns(:product)).to eq(product)
        expect(product.reload.category).to eq(category)
      end
    end

    describe 'supplier step' do
      it 'renders supplier page' do
        get :show, id: 'supplier'
        expect(response).to render_template('supplier')
      end

      it 'updates supplier id' do
        supplier = FactoryGirl.create(:mango)
        product = Product.create
        session[:product_id] = product.id

        put :update, id: 'supplier', supplier_id: supplier.id
        expect(product.reload.supplier).to eq(supplier)
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
