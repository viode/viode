class QuestionMailerJob < Que::Job
  def run(question_id)
    @question = Question.find(question_id)
    @user     = User.find(@question.intended_respondent_id)
    QuestionMailer.specified_user(@question).deliver_later
  end
end
