class QuestionsController < ApplicationController
  def index
    @questions = Question.includes(:category, :user).recent.limit(10)
  end
end
