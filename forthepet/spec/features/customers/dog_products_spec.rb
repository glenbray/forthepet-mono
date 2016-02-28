require 'rails_helper'

feature "dog products" do

  background do
    FactoryGirl.create(:dog)
  end

  scenario 'view a dog product' do
    visit '/dog'
    within('.body') do
      expect(page).to have_content('Dogs')
      expect(page).to have_content('Food')
      expect(page).to have_content('Flea & Worming')
      expect(page).to have_content('Litter')
      expect(page).to have_content('Toys')
      expect(page).to have_content('Treats')
      expect(page).to have_content('Collars & Leads')
      expect(page).to have_content('Accessories')
      expect(page).to have_content('Clean up')
      expect(page).to have_content('Beds')
      expect(page).to have_content('Grooming')
      expect(page).to have_content('Health')
    end

    within('.food') do
      expect(page).to have_content('Dry Food')
      expect(page).to have_content('Wet Food')
    end

  end

end
