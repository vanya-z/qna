require_relative 'acceptance_helper'

feature 'Destroy question', %q{
  As an authenticated user
  I want to be able to destroy my question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:own_question) { create(:question, user: user) }

  describe 'Authenticated user' do
    scenario 'deletes his question' do
      sign_in(user)
      visit question_path(own_question)
      click_on 'delete question'
      expect(current_path).to eq questions_path
      expect(page).to have_content 'Question was successfully deleted'
    end

    scenario 'tries to delete other user\'s question' do
      sign_in(user)
      visit question_path(question)
      expect(page).to_not have_link 'delete question'
    end
  end

  scenario 'Non-authenticated try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'delete question'
  end
end