module ApplicationHelper

  def link_to_author(object)
    object.user ? link_to(object.user.email, object.user) : "user deleted"
  end

  def created_at(object)
    object.created_at.year == Date.today.year ? object.created_at.to_formatted_s(:like_so) : object.created_at.to_formatted_s(:like_so_year)
  end
end
