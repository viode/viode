module CategoriesHelper
  def link_to_category_subscription(category)
    return link_to('subscribe', new_user_session_path) unless user_signed_in?

    if current_user.subscribed_to? category
      title = 'unsubscribe'
      path = unsubscribe_category_path(category)
    else
      title = 'subscribe'
      path = subscribe_category_path(category)
    end

    link_to title, path, method: :post, remote: true, class: 'btn btn-primary', data: { category_id: category.id }
  end
end
