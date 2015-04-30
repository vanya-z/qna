class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :user, counter_cache: true

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

  acts_as_votable

  after_create :calculate_rating

  scope :created_after, ->(time) { where(created_at: (Time.now - time)..Time.now) }

  def discard_questions
    self.answers.update_all(is_accepted: false, updated_at: Time.now)
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
    Tag.find_by!(name: name).questions
  end

  def self.sorting(sort, duration = nil)
    if sort == 'newest'
      duration ? created_after(duration.to_i.days).order('created_at DESC') : order('created_at DESC')
    elsif sort == 'unanswered'
      where(answers_count: 0)
    else
      order('cached_votes_score DESC')
    end
  end

  private

  def calculate_rating
    Reputation.calculate(self)
  end
end
