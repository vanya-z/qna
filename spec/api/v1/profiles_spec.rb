require 'rails_helper'

RSpec.describe 'Profiles API' do
  describe 'unauthorized' do
    %w(all me).each do |attr|
      it 'returns 401 status if there is no access_token' do
        get "/api/v1/profiles/#{attr}", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/profiles/#{attr}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end
  end

  describe 'authorized' do
    context 'GET /me' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  context 'GET /all' do
    let!(:users) { create_list(:user, 3) }
    let!(:me) { users.first }
    let!(:other_first) { users.second }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/all', format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    it 'returns list of profiles except own profile' do
      expect(response.body).to have_json_size(2).at_path("profiles")
    end

    %w(id email created_at updated_at admin).each do |attr|
      it "profile object contains #{attr}" do
        expect(response.body).to be_json_eql(other_first.send(attr.to_sym).to_json).at_path("profiles/0/#{attr}")
      end
    end
  end
end