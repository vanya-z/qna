module TagsHelper

  def tag_list(question)
    content_tag_for(:span, question.tags) do |tag|
      link_to tag.name, tag_path(tag.name), class: 'btn btn-default btn-xs'
    end
  end

  def tag_count(tag)
    tag_all(tag).count
  end

  def tag_statistic(tag)
    tags = tag_all(tag)
    day = tags.where("created_at > ?", Time.now - 1.day).count
    week = tags.where("created_at > ?", Time.now - 1.week).count
    month = tags.where("created_at > ?", Time.now - 1.month).count
    year = tags.where("created_at > ?", Time.now - 1.year).count

    first_tag = tags.first
    if first_tag
      return str = 'created ' + time_ago_in_words(first_tag.created_at) + ' ago' if first_tag.created_at > Date.today - 45.days
    end

    str = day > 0 ? day.to_s + ' asked today' : ''

    if week > day && day > 0
      return str += ', ' + week.to_s + ' this week'
    elsif week > day && day == 0
      str += week.to_s + ' asked this week'
    else
      str += ''
    end

    if month > week && week > 0
      return str += ', ' + month.to_s + ' this month'
    elsif month > week && week == 0
      str += month.to_s + ' asked this month'
    else
      str += ''
    end

    if year > month && month > 0
      return str += ', ' + year.to_s + ' this year'
    elsif year > month && month == 0
      str += year.to_s + ' asked this year'
    else
      str += ''
    end
  end

  def tag_all(tag)
    Tagging.where(tag_id: tag)
  end
end