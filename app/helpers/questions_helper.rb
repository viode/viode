module QuestionsHelper
  def link_to_question_upvote(question)
    if user_signed_in?
      klass = question.has_evaluation?(:upvotes, current_user) ? 'active' : ''

      link_to upvote_question_path(question), method: :post, remote: true,
          class: "#{klass} js-question-upvote-link",
          data: { disable_with: '<span class="fa fa-spinner fa-pulse fa-lg"></span>' } do
        content_tag :span, nil, class: 'fa fa-arrow-up fa-lg'
      end
    else
      link_to new_user_session_path do
        content_tag :span, nil, class: 'fa fa-arrow-up fa-lg'
      end
    end
  end

  def link_to_question_downvote(question)
    if user_signed_in?
      klass = question.has_evaluation?(:downvotes, current_user) ? 'active' : ''

      link_to downvote_question_path(question), method: :post, remote: true,
          class: "#{klass} js-question-downvote-link",
          data: { disable_with: '<span class="fa fa-spinner fa-pulse fa-lg"></span>' } do
        content_tag :span, nil, class: 'fa fa-arrow-down fa-lg'
      end
    else
      link_to new_user_session_path do
        content_tag :span, nil, class: 'fa fa-arrow-down fa-lg'
      end
    end
  end

  def question_author(question)
    if question.anonymous?
      'Anonymous'
    else
      link_to question.author.username, question.author
    end
  end
end
