module TagsHelper

  def tag_list(question)
    content_tag_for(:span, question.tags) do |tag|
      link_to tag.name, tag_path(tag.name), class: 'btn btn-default btn-xs tag'
    end
  end

  def questions_count(questions, period)
    time_now = Time.now
    questions.where(created_at: (time_now - period)..time_now).count
  end

  def tag_statistic(tag)
    questions = tag.questions
    if cookies[:tags_tab] == 'new'
      return stat = 'created ' + time_ago_in_words(tag.created_at) + ' ago'
    else
      periods = [
        ['day', 1, questions_count(questions, 1.day)],
        ['week', 7, questions_count(questions, 1.week)],
        ['month', 30,questions_count(questions, 1.month)],
        ['year', 365, questions_count(questions, 1.year)]]
      stat = periods[0][2] > 0 ? link_to("#{periods[0][2]} asked today", tag_path(tag.name, sort: 'newest', days: 1)) : ''
      last_period = nil
      periods.each do |p|
        if last_period.present?
          if p[2] > last_period[2] && last_period[2] > 0
            return stat.html_safe << link_to(", #{p[2]} this #{p[0]}", tag_path(tag.name, sort: 'newest', days: p[1]))
          elsif p[2] > last_period[2] && last_period[2] == 0
            stat << link_to("#{p[2]} asked this #{p[0]}", tag_path(tag.name, sort: 'newest', days: p[1]))
          else
            stat << ''
          end
        end
        last_period = p
      end
      stat.html_safe
    end
  end
end