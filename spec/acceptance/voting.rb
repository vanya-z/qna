require_relative 'acceptance_helper'

feature 'Vote question', %q{
  In order to enhance a value of a question
  As an authorized user
  I want to vote for a question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  describe 'Authenticated user' do

    scenario 'votes up for the question', js: true do
      sign_in(user)
      visit question_path(question)
      page.execute_script("$('#voting_question_#{question.id} .fa-chevron-up').click()")
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '1'
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
    end

    scenario 'votes up for the answer', js: true do
      sign_in(user)
      visit question_path(question)
      page.execute_script("$('#voting_answer_#{answer.id} .fa-chevron-up').click()")
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '1'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end
    
    scenario 'votes down for the question', js: true do
      sign_in(user)
      visit question_path(question)
      page.execute_script %($('#voting_question_#{question.id} .fa-chevron-down').click())
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '-1'
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
    end
    
    scenario 'votes down for the answer', js: true do
      sign_in(user)
      visit question_path(question)
      page.execute_script %($('#voting_answer_#{answer.id} .fa-chevron-down').click())
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '-1'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end
  end

  describe 'Non-authenticated user' do

    scenario 'try to vote up for the question', js: true do
      visit question_path(question)
      page.execute_script %($('#voting_question_#{question.id} .fa-chevron-up').click())
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end

    scenario 'try to vote up for the answer', js: true do
      visit question_path(question)
      page.execute_script %($('#voting_answer_#{answer.id} .fa-chevron-up').click())
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end
    
    scenario 'try to vote down for the question', js: true do
      visit question_path(question)
      page.execute_script %($('#voting_question_#{question.id} .fa-chevron-down').click())
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end

    scenario 'try to vote down for the answer', js: true do
      visit question_path(question)
      page.execute_script %($('#voting_answer_#{answer.id} .fa-chevron-down').click())
      expect(find("#voting_answer_#{answer.id}").find('h4')).to have_content '0'
      expect(find("#voting_question_#{question.id}").find('h4')).to have_content '0'
    end
  end
end