class SearchController < ApplicationController
  def index
    @questions = Question.search params[:query], page: params[:page], per_page: 10
  end
end
