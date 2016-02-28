require 'rails_helper'

feature "Signing in" do

  context 'valid sign in attempt' do
    background do
      user = FactoryGirl.create(:user)
      user.confirm!
    end

    scenario "Signing in with correct credentials" do
      visit '/sign-in'
      within("#new_user") do
        fill_in 'Email', :with => 'bob@jones.com'
        fill_in 'Password', :with => 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully'
    end
  end

  context 'invalid sign in attempt' do
    scenario "Signing in with a non existant account" do
      visit '/sign-in'
      within("#new_user") do
        fill_in 'Email', :with => 'invalid@email.com'
        fill_in 'Password', :with => 'invalidpassword'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Invalid email or password'
    end
  end
end
