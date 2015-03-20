class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    redirect_to root_path unless current_user == @user
  end

  def update
    redirect_to root_path and return unless current_user == @user

    if current_user.update(user_params)
      redirect_to current_user, notice: 'Settings updated!'
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
