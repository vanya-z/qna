require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:question_answered) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:own_answer) { create(:answer, question: question_answered, user: user) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'try to edit his answer', js: true do
      sign_in user
      visit question_path(question_answered)
      click_on 'Edit'
      within '.answers' do
        fill_in "edit_answer_#{own_answer.id}", with: 'edited answer'
        click_on 'Update Answer'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
    
    scenario 'try to edit other user\'s answer' do
      sign_in user
      visit question_path(question)
      expect(page).to_not have_link 'Edit'
    end
  end
end