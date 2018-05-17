class QuestionMailer < ApplicationMailer
  def specified_user(question)
    @question = question
    @user     = User.find(@question.intended_respondent_id)
    mail(to: @user.email, subject: 'Someone asked you a question', content_type: "text/html")
  end
end
