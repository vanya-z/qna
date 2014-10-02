require 'rails_helper'

RSpec.describe Answer, :type => :model do

  it { should belong_to :question }
  it { should belong_to :user }
  it { should validate_presence_of :body }

  describe 'accept' do
  	let(:question) { create(:question) }
    let(:answer1) { create(:answer, question: question) }
    let!(:answer2) { create(:answer, question: question, is_accepted: true) }

    it 'sets the answer is_accepted true' do
      answer1.accept
      answer1.reload

      expect(answer1.is_accepted).to eq true
    end

    it 'sets other question\'s answers is_accepted false ' do
      answer1.accept
      answer2.reload
      
      expect(answer2.is_accepted).to eq false
    end
  end
end
