module QuestionsHelper
  def question_author(question)
    if question.anonymous?
      'Anonymous'
    else
      link_to question.author.username, question.author
    end
  end
end
