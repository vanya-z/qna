class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :questions, through: :taggings

  validates :name, presence: true

  def self.sorting(sort_params)
    if sort_params == 'new'
      order('created_at DESC')
    elsif sort_params == 'name'
      order('name')
    else
      order('taggings_count DESC')
    end
  end
end
