require 'rails_helper'

feature 'product wizard', :type => :feature do
  before :each do
    admin = FactoryGirl.create(:admin)
    sign_in admin
  end

  describe 'GET #edit' do
    it "returns render to edit page" do
      admin = FactoryGirl.build(:admin)
      visit edit_admin_admin_path(admin.id)
      fill_in('Email', with: admin.email
      first('input[type="submit"]').click
    end
  end

  describe 'DELETE #destroy' do
    it "delete admin record" do
      click_link('Delete')
      expect(page).to have_content("Successfully deleted admin")
    end
  end
end
