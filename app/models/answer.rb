class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true
  
  accepts_nested_attributes_for :attachments, allow_destroy: true

  default_scope { order('created_at') }

  acts_as_votable

  def accept
    self.question.discard_questions
    self.reload.update(is_accepted: true)
  end

  def discard
  	self.update(is_accepted: false)
  end
end
