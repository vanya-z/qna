require 'rails_helper'

RSpec.describe TagsController, :type => :controller do  

  describe 'GET #index' do
    let(:tags) { create_list(:tag, 2) }
    before { get :index }

    it 'populates an array of all tags' do
      expect(assigns(:tags)).to match_array(tags)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end