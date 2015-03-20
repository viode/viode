class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.new
    set_answer_question
  end

  def create
    @answer = current_user.answers.new(answer_params)
    set_answer_question

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer_question
    @answer.question = Question.find params[:question_id]
  end
end
