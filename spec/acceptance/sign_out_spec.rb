require_relative 'acceptance_helper'

feature 'Siging out', %q{
  In order to logout
  As an user
  I want be able to sign out
 } do

  given(:user) { create(:user) }

  scenario "Signed in user try to sign out" do
    sign_in user
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end