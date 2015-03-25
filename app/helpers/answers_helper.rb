module AnswersHelper
  def link_to_answer_upvote(answer)
    if user_signed_in?
      klass = answer.has_evaluation?(:upvotes, current_user) ? 'active' : ''

      link_to upvote_answer_path(answer), method: :post, remote: true,
          class: "#{klass} js-answer-upvote-link",
          data: { disable_with: '<span class="fa fa-spinner fa-pulse fa-lg"></span>' } do
        content_tag :span, nil, class: 'fa fa-arrow-up fa-lg'
      end
    else
      link_to new_user_session_path do
        content_tag :span, nil, class: 'fa fa-arrow-up fa-lg'
      end
    end
  end

  def link_to_answer_downvote(answer)
    if user_signed_in?
      klass = answer.has_evaluation?(:downvotes, current_user) ? 'active' : ''

      link_to downvote_answer_path(answer), method: :post, remote: true,
          class: "#{klass} js-answer-downvote-link",
          data: { disable_with: '<span class="fa fa-spinner fa-pulse fa-lg"></span>' } do
        content_tag :span, nil, class: 'fa fa-arrow-down fa-lg'
      end
    else
      link_to new_user_session_path do
        content_tag :span, nil, class: 'fa fa-arrow-down fa-lg'
      end
    end
  end

  def answer_author(answer)
    if answer.anonymous?
      'Anonymous'
    else
      link_to answer.author.username, answer.author
    end
  end
end
