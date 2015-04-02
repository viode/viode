class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin_rights

  private

  def check_admin_rights
    render status: 404 unless current_user.admin?
  end
end
