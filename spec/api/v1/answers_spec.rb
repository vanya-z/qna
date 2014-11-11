require 'rails_helper'

describe 'Answers API' do
  describe 'GET /index' do
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question) }
    let!(:answers) { create_list(:answer, 2, question: question) }
    let!(:answer) { answers.first }

    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2).at_path("answers")
      end

      %w(id body question_id created_at updated_at user_id is_accepted).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'POST /create' do
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question) }
    let(:answers) { build(:answer) }

    context 'unauthorized'

    context 'authorized' do
      before { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), question: question, format: :json, access_token: access_token.token }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'saves the new answer in the database' do
        expect { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), question: question, format: :json, access_token: access_token.token }.to change(Answer, :count).by(1)
      end

      it 'the new answer belongs to question' do
        expect { post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), question: question, format: :json, access_token: access_token.token }.to change(question.answers, :count).by(1)
      end
    end
  end
end