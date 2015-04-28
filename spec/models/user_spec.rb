require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }

    context 'provider without email info' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {}) }

      context 'user exist and already has confirmed authorization' do
        it 'returns the user' do
          user.authorizations.create(provider: 'facebook', uid: '123456', confirmed_at: Time.now)
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user unconfirmed authorization yet' do
        it 'returns new user' do
          user.authorizations.create(provider: 'facebook', uid: '123456')
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
      end
    end

    context 'provider with email info' do
      context 'user has not authorization' do
        context 'user already exists' do
          let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
          it 'does not create new user' do
            expect { User.find_for_oauth(auth) }.to_not change(User, :count)
          end

          it 'creates authorization for user' do
            expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
          end

          it 'creates authorization with provider and uid' do
            authorization = User.find_for_oauth(auth).authorizations.first

            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end

          it 'returns the user' do
            expect(User.find_for_oauth(auth)).to eq user
          end
        end

        context 'user does not exist' do
          let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

          it 'creates new user' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
          end
          
          it 'returns new user' do
            expect(User.find_for_oauth(auth)).to be_a(User)
          end

          it 'fills user email' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq auth.info[:email]
          end

          it 'creates authorization for user' do
            user = User.find_for_oauth(auth)
            expect(user.authorizations).to_not be_empty
          end

          it 'creates authorization with provider and uid' do
            authorization = User.find_for_oauth(auth).authorizations.first

            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end
        end
      end
    end
  end
end
