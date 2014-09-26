require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to share my knowledge
  As an authenticated user
  I want to create an answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates an answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'My answer body'
    click_on 'Create'

    expect(page).to have_content 'My answer body'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user tries to create answer' do    
    visit question_path(question)

    expect(page).not_to have_button 'Create'
  end
end