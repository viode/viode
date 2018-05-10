# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create upvote downvote star]
  before_action :find_question, only: %i[show upvote downvote star]

  def index
    @top_categories = Category.popular.limit(5)
    @labels = ActsAsTaggableOn::Tag.most_used
    @questions = Question.includes(:author, :category).recent.page(params[:page]).per(20)
  end

  def show
    if params[:permalink].blank? || params[:permalink] != @question.permalink
      redirect_to(@question, status: :moved_permanently)
    end

    @category_questions = @question.category.questions.limit(5)
    @related_questions = Question.related_to(@question).limit(5)
    @question.increment_views
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
    @question.upvote_by current_user

    respond_to do |format|
      format.html { redirect_to @question }
      format.js
    end
  end

  def downvote
    @question.downvote_by current_user

    respond_to do |format|
      format.html { redirect_to @question }
      format.js
    end
  end

  def star
    @question.star_by current_user

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
