class Settings::AccountsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def update
    if current_user.valid_password? params[:user][:current_password]
      if current_user.update(user_params)
        flash[:success] = 'Settings successfully saved.'
        redirect_to settings_account_path
      else
        render :show
      end
    else
      flash[:error] = 'Current password is incorrect.'
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
