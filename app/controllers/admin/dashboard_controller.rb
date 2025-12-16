module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_manager!

    def show
      @user = current_user
    end

    private

    def authorize_manager!
      return if current_user.manager?

      redirect_to root_path, alert: "Доступ заборонено"
    end
  end
end
