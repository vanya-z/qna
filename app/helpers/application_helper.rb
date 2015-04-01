module ApplicationHelper

  def social_icon(provider)
    icons = {
      facebook: 'fa-facebook-official',
      twitter: 'fa-twitter-square',
      vk: 'fa-vk'
    }
    content_tag(:i, nil, class: "fa fa-2x ml-5 #{icons[provider]}")
  end

  def user_avatar_link(user)
    user == current_user ? link_to(avatar_email(user), edit_user_registration_path) : link_to(avatar_email(user), user)
  end

  def avatar_email(user)
    content_tag(:span, (image_tag avatar_url(user), class: 'img-circle')) +
    content_tag(:small, user.email, class: 'ml-5')
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=32"
  end

  def deleted_user
    content_tag(:span, (image_tag 'avatar.png', size: "32x32", alt: 'user deleted', class: 'img-circle')) +
    content_tag(:small, 'user deleted', class: 'ml-5')
  end

  def created_by_block(object)
    content_tag(:div, class: "#{ object.class.to_s == 'Answer' && object.is_accepted ? 'bg-success pl-5' : 'pl-5' }") do
      content_tag(:small, class: 'text-muted') do
        "#{object.class.to_s == 'Answer' ? 'answered ' : 'asked '}" + created_at(object)
      end +
      content_tag(:div, class: 'pv-5') do
        object.user ? user_avatar_link(object.user) : deleted_user
      end
    end    
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    Redcarpet::Markdown.new(renderer, options = {}).render(text).html_safe
  end
  
  def markdown_to_text(text)
    Nokogiri::HTML(markdown(text)).text
  end

  def link_to_author(object, options = {})
    object.user ? link_to(object.user.email, object.user, options) : "user deleted"
  end

  def created_at(object)
    object.created_at.year == Date.today.year ? object.created_at.to_formatted_s(:like_so) : object.created_at.to_formatted_s(:like_so_year)
  end

  def answers_count(question)
    klass = question.answers_count > 0 ? question.answers.find_by(is_accepted: true).present? ? 'bg-primary text-accepted' : 'bg-primary text-muted' : nil
    content_tag(:div, class: klass) do
      content_tag(:div, question.answers_count) +
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
