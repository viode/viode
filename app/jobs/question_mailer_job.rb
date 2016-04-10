class QuestionMailerJob < ActiveJob::Base
  queue_as :mailer

  def perform(question)
    @question = question
    @user     = User.find(question.intended_respondent)
    QuestionMailer.specified_user(@question).deliver_later 
  end
end