module TagsHelper

  def tag_list(question)
    content_tag_for(:span, question.tags) do |tag|
      link_to tag.name, tag_path(tag.name), class: 'btn btn-default btn-xs tag'
    end
  end

  def tag_answers_count(tags, duration)
    tags.where("created_at > ?", Time.now - duration).count
  end

  def tag_statistic(tag)
    tags = tag_all(tag)
    # first_tag = tags.first
    # if first_tag
    #   return str = 'created ' + time_ago_in_words(first_tag.created_at) + ' ago' if first_tag.created_at > Date.today - 45.days
    # end

    periods = [
      {name: 'day', answers_count: tag_answers_count(tags, 1.day)},
      {name: 'week', answers_count: tag_answers_count(tags, 1.week)},
      {name: 'month', answers_count: tag_answers_count(tags, 1.month)},
      {name: 'year', answers_count: tag_answers_count(tags, 1.year)}
    ]

    str = periods[0][:answers_count] > 0 ? periods[0][answers_count].to_s + ' asked today' : ''
    last_p = nil

    periods.each_with_index do |p, i|
      if last_p.present?
        if p[:answers_count] > last_p[:answers_count] && last_p[:answers_count] > 0
          return str << ', ' + p[:answers_count].to_s + " this #{p[:name]}"
        elsif p[:answers_count] > last_p[:answers_count] && last_p[:answers_count] == 0
          str << p[:answers_count].to_s + " asked this #{p[:name]}"
        else
          str << ''
        end
      end
      last_p = p
    end
    str
  end

  def tag_all(tag)
    Tagging.where(tag_id: tag)
  end
end