class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: [:upvote, :downvote]

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

  def upvote
    # TODO: refactor to a custom method
    if @answer.has_evaluation?(:upvotes, current_user)
      @answer.delete_evaluation(:upvotes, current_user)
    else
      @answer.delete_evaluation(:downvotes, current_user)
      @answer.add_evaluation(:upvotes, 1, current_user)
    end

    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.js
    end
  end

  def downvote
    # TODO: refactor to a custom method
    if @answer.has_evaluation?(:downvotes, current_user)
      @answer.delete_evaluation(:downvotes, current_user)
    else
      @answer.delete_evaluation(:upvotes, current_user)
      @answer.add_evaluation(:downvotes, -1, current_user)
    end

    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.js
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :anonymous)
  end

  def set_answer_question
    @answer.question = Question.find params[:question_id]
  end

  def find_answer
    @answer = Answer.find params[:id]
  end
end
