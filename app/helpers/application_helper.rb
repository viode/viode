module ApplicationHelper
  def flash_class(type)
    case type
    when 'alert' then 'alert-warning'
    when 'error' then 'alert-danger'
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    else type
    end
  end

  def time_tag_for(object)
    time = object.created_at
    time_tag time, "#{distance_of_time_in_words_to_now time} ago", title: l(time, format: :long)
  end

  def author_avatar(post)
    unless post.anonymous? || post.author.avatar.blank?
      image_tag post.author.avatar.thumb.url, size: '18', alt: post.author.username
    end
  end

  # TODO: refactor
  def title(*args)
    @title_helper_title ||= []
    @title_helper_title_options ||= { separator: ' - ', headline: nil, sitename: nil }
    options = args.extract_options!

    @title_helper_title += args
    @title_helper_title_options.merge!(options)

    t =  @title_helper_title.clone
    t << @title_helper_title_options[:sitename]
    t << @title_helper_title_options[:headline]
    t.compact.join(@title_helper_title_options[:separator])
  end
end
