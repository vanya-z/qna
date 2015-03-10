require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should belong_to :user }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :attachments }
  it { should have_many :taggings }
  it { should have_many :tags }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe 'discard_questions' do
    let!(:question) { create :question }
    let!(:answer1) { create :answer, question: question, is_accepted: true }
    let!(:answer2) { create :answer, question: question, is_accepted: false }

    it 'sets all answer\'s is_accepted to false' do
      question.discard_questions
      expect(answer1.reload.is_accepted).to eq false
      expect(answer2.reload.is_accepted).to eq false
    end
  end
end
