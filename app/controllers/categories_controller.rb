class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]
  before_action :find_category, only: [:show, :subscribe, :unsubscribe]

  def index
    @categories = Category.order(:name)
  end

  def show
    @questions = @category.questions.includes(:answers, :author).recent.page(params[:page]).per(20)
  end

  def subscribe
    current_user.subscribe_to @category

    respond_to do |format|
      format.html { redirect_to @category }
      format.js
    end
  end

  def unsubscribe
    current_user.unsubscribe_from @category

    respond_to do |format|
      format.html { redirect_to @category }
      format.js
    end
  end

  private

  def find_category
    @category = Category.find_by_permalink! params[:permalink]
  end
end
