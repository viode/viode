module ApplicationHelper
  def time_tag_for(object)
    time = object.created_at
    time_tag time, "#{distance_of_time_in_words_to_now time} ago", title: l(time, format: :long)
  end
end
