require_relative 'acceptance_helper'

feature 'Edit comment', %q{
  In order to improve the comment
  As an author of comment
  I want to edit the comment
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:comment) { create(:comment, commentable_id: question.id, commentable_type: question.class) }
  given(:own_comment) { create(:comment, commentable_id: question.id, commentable_type: question.class, user: user) }

  describe 'Authenticated user' do
    scenario 'edit own comment', js: true do
      sign_in(user)
      visit question_path(question)

      within 'form#new_comment' do
        fill_in 'Your comment', with: 'My comment body'
        click_on 'Add comment'
      end

      click_on 'edit'
      within 'form.edit_comment' do
        fill_in 'Edit comment', with: 'My edited comment body'
        click_on 'update'
      end

      expect(page).to have_content 'My edited comment body'
      expect(current_path).to eq question_path(question)
    end
  end

  scenario 'Non-authenticated user tries to create answer' do    
    visit question_path(question)

    expect(page).not_to have_button 'Add comment'
  end
end