class Settings::PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def update
    # TODO: validate password confirmation
    if current_user.valid_password? params[:user][:current_password]
      if current_user.update(user_params)
        sign_in current_user, bypass: true
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
