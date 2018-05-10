# frozen_string_literal: true

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

  def author_avatar(post)
    if post.author.avatar.present? && !post.anonymous?
      image_tag post.author.avatar.thumb.url, size: '18', alt: post.author.username
    elsif post.author.avatar.blank? && !post.anonymous?
      image_tag gravatar_url(post.author, 18), alt: post.author.username
    end
  end

  def gravatar_url(user, size)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip.downcase)}?s=#{size}"
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
