require_relative 'acceptance_helper'

feature 'Discard answer', %q{
  In order to unmark right answer
  As an owner of question
  I want to discard the answer
} do
  given(:questioner) { create(:user) }
  given(:answerer) { create(:user) }
  given!(:question) { create(:question, user: questioner) }
  given!(:answer) { create(:answer, question: question, user: answerer, is_accepted: true) }

  describe 'Authenticated user' do
    scenario 'discards an answer of own question', js: true do
      sign_in(questioner)
      visit question_path(question)
      click_on 'Discard'
      expect(page).to have_content 'Accept'
    end
    scenario 'tries to discard other user\'s answer', js: true do
      sign_in(answerer)
      visit question_path(question)

      expect(page).to_not have_link 'Discard'
    end
  end

  scenario 'Non-authenticated user tries to discard answer' do    
    visit question_path(question)

    expect(page).to_not have_link 'Discard'
  end
end