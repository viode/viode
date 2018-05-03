class Settings::PasswordsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    # TODO: validate password confirmation
    if current_user.valid_password? params[:user][:current_password]
      if current_user.update(user_params)
        bypass_sign_in current_user
        flash[:success] = 'Password successfully updated.'
        redirect_to settings_password_path
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
    params.require(:user).permit(:password)
  end
end
