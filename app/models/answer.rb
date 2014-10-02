class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

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
