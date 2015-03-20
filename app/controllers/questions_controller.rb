class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.includes(:category, :user).recent.limit(20)
  end

  def show
    @question = Question.find params[:id]
    Question.where(id: @question.id).update_all('views=views+1')
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :category_id)
  end
end
