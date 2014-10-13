class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable

  validates :body, presence: true
  
  accepts_nested_attributes_for :attachments, allow_destroy: true

  default_scope { order('created_at') }

  def accept
    self.question.answers.update_all(is_accepted: false)
    self.reload
    self.update(is_accepted: true)
  end

  def discard
  	self.update(is_accepted: false)
  end
end
