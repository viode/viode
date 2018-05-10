# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!, :check_admin_rights

    private

    def check_admin_rights
      render status: :not_found unless current_user.admin?
    end
  end
end
