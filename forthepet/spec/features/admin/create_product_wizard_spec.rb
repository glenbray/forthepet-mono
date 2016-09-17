require 'rails_helper'

feature 'product wizard', :type => :feature do

  before :each do
    include Warden::Test::Helpers
    Warden.test_mode!

    FactoryGirl.create(:admin)

    visit '/admin/sign-in'
    fill_in 'Login', with: 'test@admin.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario 'admin user should be able to navigate to product wizard page' do
    visit '/admin/product-wizard'
    expect(page).to have_content('Product Wizard')
  end

  scenario 'admin should be able to create a product through wizard' do
    # Brand
    FactoryGirl.create(:brand)

    # Categories
    FactoryGirl.create(:dog)
    FactoryGirl.create(:cat)

    #Suppliers
    FactoryGirl.create(:apple_supplier)
    FactoryGirl.create(:orange_supplier)
    FactoryGirl.create(:mango_supplier)

    visit '/admin/product-wizard'
    expect(page).to have_content('Select Category')
    choose('Dog')
    click_button 'Continue'

    # Suppliers
    expect(page).to have_content('Select Supplier')

    fill_in 'q_name_cont', with: 'mango'
    click_button 'Search'
    expect(page).to have_content('Mango Limited')
    click_link('select')

    # Products
    expect(page).to have_content('Product Details')

    fill_in 'Name', with: 'Box of apples'
    select 'brand', :from => "product_brand_id"

    fill_in 'Price', with: 30
    fill_in 'Quantity', with: 100
    fill_in 'Sku', with: 'boxap3'
    fill_in 'Description', with: 'this is a description'
    fill_in 'Weight', with: 20
    click_button 'Continue'

    # Images
    expect(page).to have_content('Upload Images')

  end

end

# search and select category
# search and select supplier
# add product details
# upload product images
