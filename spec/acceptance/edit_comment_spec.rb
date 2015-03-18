require_relative 'acceptance_helper'

feature 'Edit comment', %q{
  In order to improve the comment
  As an author of comment
  I want to edit the comment
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:comment) { create(:comment, commentable: question, user: user) }
  given(:another_user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'edit own comment', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'edit'
      within 'form.edit_comment' do
        fill_in 'Edit comment', with: 'My edited comment body'
        click_on 'Update comment'
      end

      expect(page).to have_content 'My edited comment body'
      expect(current_path).to eq question_path(question)
    end

    scenario 'try to edit other user\'s comment' do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_link 'edit'
    end
  end

  scenario 'Non-authenticated user tries to edit answer' do    
    visit question_path(question)

    expect(page).not_to have_link 'edit'
  end
end