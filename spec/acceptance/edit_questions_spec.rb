require_relative 'acceptance_helper'

feature 'Edit question', %q{
  In order to improve question
  As an authenticated user
  I want to be able to edit my question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:own_question) { create(:question, user: user) }

  scenario 'Non-authenticated try to edit question' do
    visit question_path(question)
    expect(page).not_to have_link 'edit question'        
  end

  describe 'Authenticated user' do
    scenario 'edits his question', js: true do
      sign_in(user)

      visit question_path(own_question)
      click_on 'edit question'
      within '.edit_question' do
        fill_in 'Title', with: 'New title'
        fill_in 'wmd-input-body', with: 'New body'
        click_on 'Update Question'
      end
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New body'
    end
    
    describe 'try to edit other user\'s question' do
      scenario 'via "edit question" link' do
        sign_in user
        visit question_path(question)
        expect(page).to_not have_link 'edit question'
      end

      scenario 'by visiting edit path' do
        sign_in user
        visit edit_question_path(question)
        expect(page).to have_content 'You are not authorized to access this page.'
      end
    end
  end
end