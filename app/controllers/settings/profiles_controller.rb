class Settings::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Settings successfully saved.'
      redirect_to settings_profile_path
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :bio, :avatar, :remove_avatar)
  end
end
