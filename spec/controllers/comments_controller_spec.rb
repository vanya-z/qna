require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  login_user

  describe 'POST #create' do
    let(:question) { create :question }
    let(:answer) { create :answer }

    it 'loads question if parent is question' do
      post :create, comment: attributes_for(:comment), question_id: question, format: :js
      expect(assigns(:parent)).to eq question
    end

    it 'loads answer if parent is answer' do
      post :create, comment: attributes_for(:comment), answer_id: answer, format: :js
      expect(assigns(:parent)).to eq answer
    end    
  end

  describe 'PATCH #update' do
    let(:comment) { create :comment, user: @user }

    context 'valid attributes' do
      it 'assigns the requested comment to @comment' do
        patch :update, id: comment, comment: attributes_for(:comment), format: :js
        expect(assigns(:comment)).to eq comment
      end

      it 'changes comment attributes' do
        patch :update, id: comment, comment: { body: 'edited body'}, format: :js
        comment.reload
        expect(comment.body).to eq 'edited body'
      end

      it 'renders update.js.erb' do
        patch :update, id: comment, comment: attributes_for(:comment), format: :js
        expect(response).to render_template :update
      end
    end

    context 'invalid attributes' do
      it 'it does not change comment\'s attributes' do
        patch :update, id: comment, comment: {body: nil}, format: :js
        expect(comment.body).to eq "My comment"
      end

      it 'renders update.js.erb' do
        patch :update, id: comment, comment: {body: nil}, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #comment' do
    let!(:comment) { create :comment, user: @user }

    it 'deletes comment' do
      expect { delete :destroy, id: comment, format: :js }.to change(Comment, :count).by(-1)
    end

    it 'renders destroy.js.erb' do
      delete :destroy, id: comment, format: :js
      expect(response).to render_template :destroy
    end
  end
end
