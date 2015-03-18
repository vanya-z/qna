module QuestionsHelper

  def accept_discard_link(answer)
    answer.is_accepted? ? (link_to 'Discard', discard_answer_path(answer), method: :post, remote: true, class: 'btn btn-link') : (link_to 'Accept', accept_answer_path(answer), method: :post, remote: true, class: 'btn btn-link')
  end
end
