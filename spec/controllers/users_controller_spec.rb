require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { create :user }

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      get :show, id: user
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      get :show, id: user
      expect(response).to render_template :show
    end
  end
end
