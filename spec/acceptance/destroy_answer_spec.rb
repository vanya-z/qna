require_relative 'acceptance_helper'

feature 'Answer deleting', %q{
  In order to fix mistake
  As an author of answer
  I'd like ot be able to delete my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:question_answered) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:own_answer) { create(:answer, question: question_answered, user: user) }

  scenario 'Unauthenticated user try to delete question' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete'
  end

  describe 'Authenticated user' do
    scenario 'try to delete his answer', js: true do
      sign_in user
      visit question_path(question_answered)
      expect(page).to have_content own_answer.body
      sleep 1
      click_on 'Delete'
      expect(page).to_not have_content own_answer.body
    end
    
    scenario 'try to delete other user\'s answer' do
      sign_in user
      visit question_path(question)
      expect(page).to_not have_link 'Delete'
    end
  end
end