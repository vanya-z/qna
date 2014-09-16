require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer, question_id: question) }.to change(Answer, :count).by(1)
      end

      it 'redirects to question view' do
        post :create, answer: attributes_for(:answer, question_id: question)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: attributes_for(:invalid_answer, question_id: question) }.to_not change(Answer, :count)
      end

      it 're-renders question view' do
        post :create, answer: attributes_for(:invalid_answer, question_id: question)
        expect(response).to render_template ("questions/show")
      end
    end
  end
end
