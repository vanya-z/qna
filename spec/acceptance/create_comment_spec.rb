require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to clarify the question
  As an authenticated user
  I want to comment the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    scenario 'comments the question', js: true do
      sign_in(user)
      visit question_path(question)
      within 'form#new_comment' do
        fill_in 'Your comment', with: 'My comment body'
        click_on 'Add comment'
      end

      expect(page).to have_content 'My comment body'
      expect(current_path).to eq question_path(question)
    end
  end

  scenario 'Non-authenticated user tries to create answer' do    
    visit question_path(question)

    expect(page).not_to have_button 'Add comment'
  end
end