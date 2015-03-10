class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

  acts_as_votable

  def discard_questions
    self.answers.update_all(is_accepted: false)
  end
   
  def all_tags
    self.tags.map(&:name).join(", ")
  end
  
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end
end
