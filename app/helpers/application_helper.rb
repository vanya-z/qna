module ApplicationHelper

  def link_to_author(a)
    a.user ? link_to(a.user.email, a.user) : "user deleted"
  end
end
