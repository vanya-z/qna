module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    Redcarpet::Markdown.new(renderer, options = {}).render(text).html_safe
  end
  
  def markdown_to_text(text)
    Nokogiri::HTML(markdown(text)).text
  end

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

  def icon_by_filename(name)
    extension = File.extname(name)
    extensions = {
      'image' => ['.jpg', '.jpeg', '.bmp', '.png', '.gif'],
      'archive' => ['.zip', '.rar', '.7z'],
      'excel' => ['.xls', '.xlsx'],
      'word' => ['.doc', '.docx'],
      'powerpoint' => ['.ppt', '.pptx'],
      'code' => ['.rb', '.html', '.slim', '.erb', '.css', '.scss', '.js', '.coffee'],
      'text' => '.txt',
      'video' => ['.avi', '.mp4', '.mkv', '.flv'],
      'audio' => ['.mp3', '.acc', '.wav']
    }
    extensions.each do |key, value|
      @icon = content_tag(:i, " #{name}", class: "fa fa-file-#{key}-o") if value.include?(extension)
    end
    @icon || content_tag(:i, name, class: 'fa fa-file-o')
  end
end
