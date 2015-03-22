class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category  = Category.find params[:id]
    @questions = @category.questions.includes(:user).recent.page(params[:page]).per(20)
  end
end
