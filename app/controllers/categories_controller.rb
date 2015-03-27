class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category  = Category.find params[:id]
    @questions = @category.questions.includes(:answers, :author).recent.page(params[:page]).per(20)
  end
end
