module VotesHelper

  def voting(votable)
    content_tag(:div, class: 'btn-group-vertical', id: "voting_#{votable.class.to_s.downcase}_#{votable.id.to_s}") do
      content_tag(:div, vote_up(votable), class: 'btn-group') +
      content_tag(:div, votes(votable), class: 'btn-group votes-count') +
      content_tag(:div, vote_down(votable), class: 'btn-group')
    end
  end

  def vote_up(votable)
    link_to votable_votes_path(votable, vote: 'up'), title: votable.class.to_s == 'Question' ? 'This question shows research effort; it is useful and clear' : 'This answer is useful', method: :post, remote: true do
      content_tag(:i, nil, class: 'fa fa-chevron-circle-up fa-2x')
    end
  end

  def vote_down(votable)
    link_to votable_votes_path(votable, vote: 'down'), title: votable.class.to_s == 'Question' ? 'This question does not show any research effort; it is unclear or not useful' : 'This answer is not useful', method: :post, remote: true do
      content_tag(:i, nil, class: 'fa fa-chevron-circle-down fa-2x')
    end
  end

  def votes(votable)
    content_tag(:div, votable.cached_votes_score, class: 'votes')
  end

  def votable_votes_path(votable, options = {})
    votable.class.to_s == 'Question' ? question_votes_path(votable, options) : answer_votes_path(votable, options)
  end

  def votes_stat(votable)
    content_tag(:div, class: 'votes-stat') do
      votes(votable) +
      content_tag(:div, content_tag(:small, 'votes'))
    end
  end
end