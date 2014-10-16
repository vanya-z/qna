require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to share my knowledge
  As an authenticated user
  I want to create an answer
} do

  given(:user) { create(:user) }
  given(:own_question) { create(:question, user: user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    scenario 'answers other user\'s question', js: true do
      sign_in(user)
      visit question_path(question)
      within "form#new_answer" do
        fill_in 'Body', with: 'My answer body'
        click_on 'Create'
      end

      expect(page).to have_content 'My answer body'
      expect(current_path).to eq question_path(question)
    end

    scenario 'tries to answer own question' do
      sign_in(user)
      visit question_path(own_question)
      expect(page).not_to have_selector 'form#new_answer'
    end
  end

  scenario 'Non-authenticated user tries to create answer' do    
    visit question_path(question)

    expect(page).not_to have_button 'Create'
  end
end