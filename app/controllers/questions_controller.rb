class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @categories = Category.limit(5)
    @labels = ActsAsTaggableOn::Tag.most_used
    @questions = Question.includes(:answers, :category, :user).recent.page(params[:page]).per(20)
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
    params.require(:question).permit(:title, :body, :category_id, :tag_list)
  end
end
