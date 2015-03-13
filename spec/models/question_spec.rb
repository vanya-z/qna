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

  describe 'tags' do
    let!(:question) { create :question }
    let!(:tag1) { create :tag, name: 'name1' }
    let!(:tag2) { create :tag, name: 'name2' }
    let!(:tagging1) { create :tagging, question: question, tag: tag1 }
    let!(:tagging2) { create :tagging, question: question, tag: tag2 }

    context 'all_tags' do
      it 'returns all tags of the question as a string separated by commas' do
        string = question.all_tags
        expect(string).to eq "name1, name2"
      end
    end

    context 'all_tags=(names)' do
      names = 'name1, name3, name4'

      it 'creates new tags' do
        expect{ question.all_tags=(names) }.to change(Tag, :count).by(2)
      end

      it 'create new taggings' do
        expect{ question.all_tags=(names) }.to change(Tagging, :count).by(1)
      end

      it 'assigns new tags' do
        question.all_tags=(names)
        string = question.all_tags
        expect(string).to eq "name1, name3, name4"
      end
    end

    context 'self.tagged_with(name)' do
      it 'returns the question' do
        q = Question.tagged_with('name1')
        expect(q).to eq [question]
      end
    end
  end
end
