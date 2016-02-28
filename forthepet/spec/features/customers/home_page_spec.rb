require 'rails_helper'

feature "Home page menu" do
  scenario 'navigates to Dog products' do
    visit '/'
    click_link('Dog', match: :first, exact: true)
    expect(page).to have_content('No Deals Currently Available')
  end

  scenario 'navigates to Cat products' do
    visit '/'
    click_link('Cat', match: :first, exact: true)
    expect(page).to have_content('No Deals Currently Available')
  end

  scenario 'navigates to Misc products' do
    visit '/'
    click_link('Misc', match: :first, exact: true)
    expect(page).to have_content('No Deals Currently Available')
  end

  scenario 'navigates to Refer Friends' do
    visit '/'
    click_link('Refer Friends', match: :first, exact: true)
    expect(page).to have_content('Refer your friendsFor awesome rewards!')
  end

  scenario 'navigates to How it Works' do
    visit '/'
    click_link('How it works', match: :first, exact: true)
    expect(page).to have_content('How does For the Pet work?')
  end

  scenario 'navigates to About' do
    visit '/'
    click_link('About', match: :first, exact: true)
    expect(page).to have_content('About For the Pet')
  end
end
