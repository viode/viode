class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def answers
    @answers = @user.answers.recent.page(params[:page]).per(20)
  end

  def questions
    @questions = @user.questions.recent.page(params[:page]).per(20)
  end

  private

  def find_user
    @user = User.find_by_username! params[:username]
  end
end
