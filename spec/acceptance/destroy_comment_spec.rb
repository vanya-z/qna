require_relative 'acceptance_helper'

feature 'Destroy comment', %q{
  In order to hide the comment
  As an author of comment
  I want to delete the comment
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:comment) { create(:comment, commentable: question, user: user) }
  given(:another_user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'delete own comment', js: true do
      sign_in(user)
      visit question_path(question)
      sleep 1
      click_on 'remove'

      expect(page).to_not have_content comment.body
      expect(current_path).to eq question_path(question)
    end

    scenario 'try to delete other user\'s comment' do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_link 'remove'
    end
  end

  scenario 'Non-authenticated user tries to delete answer' do    
    visit question_path(question)

    expect(page).not_to have_link 'remove'
  end
end