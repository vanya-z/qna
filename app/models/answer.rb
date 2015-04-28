class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true
  
  accepts_nested_attributes_for :attachments, allow_destroy: true

  acts_as_votable

  after_create :calculate_rating

  def accept
    self.question.discard_questions
    self.reload.update(is_accepted: true)
  end

  def discard
  	self.update(is_accepted: false)
  end

  private

  def calculate_rating
    Reputation.calculate(self)
  end
end
