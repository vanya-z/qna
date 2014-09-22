require 'rails_helper'

feature 'Update question', %q{
  In order to improve question
  As an authenticated user
  I want to be able to update the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user updates the question' do
    sign_in(user)

    visit question_path(question)
    click_on 'edit question'
    fill_in 'Title', with: 'New title'
    fill_in 'Body', with: 'New body'
    click_on 'Update Question'
    expect(page).to have_content 'New title'
    expect(page).to have_content 'New body'
  end

  scenario 'Non-authenticated try to edit question' do
    visit question_path(question)
    expect(page).not_to have_link 'edit question'        
  end
end