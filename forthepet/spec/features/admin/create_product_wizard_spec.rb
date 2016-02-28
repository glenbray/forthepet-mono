require 'rails_helper'

feature 'product wizard', :type => :feature do

  background do
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :admin)

    FactoryGirl.create(:dog)
    FactoryGirl.create(:cat)
    FactoryGirl.create(:apple)
    FactoryGirl.create(:orange)
    FactoryGirl.create(:mango)
  end

  scenario 'admin user should be able to navigate to product wizard page' do
    visit '/admin/product-wizard'
    expect(page).to have_content('Product Wizard')
  end

  scenario 'admin should be able to create a product through wizard' do

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
    fill_in 'Brand', with: 'appletiser'
    fill_in 'Price', with: 30
    fill_in 'Quantity', with: 100
    fill_in 'Sku', with: 'boxap3'
    fill_in 'Description', with: 'this is a description'
    click_button 'Continue'

    # Images
    expect(page).to have_content('Upload Images')

  end

end

# search and select category
# search and select supplier
# add product details
# upload product images
