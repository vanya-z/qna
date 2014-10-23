require 'rails_helper'

RSpec.describe Answer, :type => :model do

  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :attachments }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe 'accept' do
  	let(:question) { create(:question) }
    let(:answer1) { create(:answer, question: question) }
    let!(:answer2) { create(:answer, question: question, is_accepted: true) }

    it 'sets the answer is_accepted true' do
      answer1.accept
      expect(answer1.reload.is_accepted).to eq true
    end

    it 'sets other question\'s answers is_accepted false ' do
      answer1.accept
      expect(answer2.reload.is_accepted).to eq false
    end
  end

  describe 'discard' do
    let(:answer) { create(:answer, is_accepted: true) }

    it 'sets the answer is_accepted false' do
      answer.discard
      expect(answer.reload.is_accepted).to eq false
    end
  end
end
