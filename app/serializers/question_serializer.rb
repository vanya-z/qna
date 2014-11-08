class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title, :attachments
  has_many :comments

  def short_title
    object.title.truncate(10)
  end

  def attachments
    object.attachments.map { |a| {url: a.file.url, filename: a.file.file.filename} }
  end
end