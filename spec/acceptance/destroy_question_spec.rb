require_relative 'acceptance_helper'

feature 'Destroy question', %q{
  As an authenticated user
  I want to be able to destroy the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user destroys the question' do
    sign_in(user)

    visit question_path(question)
    click_on 'delete question'
    expect(current_path).to eq questions_path
    expect(page).to have_content 'Question was successfully deleted'
  end

  scenario 'Non-authenticated try to edit question' do
    visit question_path(question)
    expect(page).not_to have_link 'delete question'        
  end
end