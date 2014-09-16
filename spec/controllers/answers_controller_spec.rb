require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer, question_id: question) }.to change(Answer, :count).by(1)
      end

      it 'redirects to question view' do
        post :create, answer: attributes_for(:answer, question_id: question)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: attributes_for(:invalid_answer, question_id: question) }.to_not change(Answer, :count)
      end

      it 're-renders question view' do
        post :create, answer: attributes_for(:invalid_answer, question_id: question)
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, answer: attributes_for(:answer, question_id: question)
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, id: answer, answer: {body: 'new body', question_id: question}
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to the question view' do
        patch :update, id: answer, answer: attributes_for(:answer, question_id: question)
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: answer, answer: {body: nil, question_id: question} }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 're-renders question view' do
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
