require_relative 'acceptance_helper'

feature 'Accept answer', %q{
  In order to choose right answer
  As an owner of question
  I want to check the answer as accepted
} do

  given(:questioner) { create(:user) }
  given(:answerer) { create(:user) }
  given!(:question) { create(:question, user: questioner) }
  given!(:answer) { create(:answer, question: question, user: answerer) }
  describe 'Authenticated user' do
    scenario 'accepts an answer of own question', js: true do
      sign_in(questioner)
      visit question_path(question)
      click_on 'Accept'
      expect(page).to have_content 'Discard'
    end
    scenario 'tries to accept other user\'s answer', js: true do
      sign_in(answerer)
      visit question_path(question)

      expect(page).to_not have_link 'Accept'
    end
  end

  scenario 'Non-authenticated user tries to accept answer' do    
    visit question_path(question)

    expect(page).to_not have_link 'Accept'
  end
end