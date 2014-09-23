require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'POST #create' do
    context 'authenticated user' do

      login_user

      context 'with valid attributes' do
        it 'saves the new answer in the database' do
          expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
        end

        it 'redirects to question view' do
          post :create, question_id: question, answer: attributes_for(:answer)
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
        end

        it 're-renders question view' do
          post :create, question_id: question, answer: attributes_for(:invalid_answer)
          expect(response).to render_template 'questions/show'
        end
      end
    end

    context 'non-authenticated user' do
      it 'redirects to new_user_session_path' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do

    login_user

    context 'valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, question_id: answer.question, id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, question_id: answer.question, id: answer, answer: { body: 'new body' }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to the question view' do
        patch :update, question_id: answer.question, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to answer.question
      end
    end

    context 'invalid attributes' do
      before { patch :update, question_id: question, id: answer, answer: { body: nil } }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 're-renders question view' do
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    before { answer }

    it 'deletes answer' do
      expect { delete :destroy, question_id: answer.question, id: answer }.to change(Answer, :count).by(-1)
    end

    it 'redirect to question view' do
      delete :destroy, question_id: answer.question, id: answer
      expect(response).to redirect_to answer.question
    end
  end
end
