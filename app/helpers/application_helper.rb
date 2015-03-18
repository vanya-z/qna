module ApplicationHelper

  def link_to_author(object)
    object.user ? link_to(object.user.email, object.user) : "user deleted"
  end

  def created_at(object)
    object.created_at.year == Date.today.year ? object.created_at.to_formatted_s(:like_so) : object.created_at.to_formatted_s(:like_so_year)
  end

  def answers_count(question)
    klass = question.answers.count > 0 ? question.answers.find_by(is_accepted: true).present? ? 'bg-primary text-accepted' : 'bg-primary text-muted' : nil
    content_tag(:div, class: klass) do
      content_tag(:div, question.answers.count) +
      content_tag(:div, content_tag(:small, 'answers'))
    end
  end
end
