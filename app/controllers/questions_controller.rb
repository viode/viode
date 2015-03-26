class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :upvote, :downvote]
  before_action :find_question, only: [:show, :upvote, :downvote]

  def index
    @categories = Category.limit(5)
    @labels = ActsAsTaggableOn::Tag.most_used
    @questions = Question.includes(:author, :category).recent.page(params[:page]).per(20)
  end

  def show
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

  def upvote
    # TODO: refactor to a custom method
    if @question.has_evaluation?(:upvotes, current_user)
      @question.delete_evaluation(:upvotes, current_user)
    else
      @question.delete_evaluation(:downvotes, current_user)
      @question.add_evaluation(:upvotes, 1, current_user)
    end

    respond_to do |format|
      format.html { redirect_to @question }
      format.js
    end
  end

  def downvote
    # TODO: refactor to a custom method
    if @question.has_evaluation?(:downvotes, current_user)
      @question.delete_evaluation(:downvotes, current_user)
    else
      @question.delete_evaluation(:upvotes, current_user)
      @question.add_evaluation(:downvotes, -1, current_user)
    end

    respond_to do |format|
      format.html { redirect_to @question }
      format.js
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category_id, :tag_list, :anonymous)
  end

  def find_question
    @question = Question.find params[:id]
  end
end
