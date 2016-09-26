class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:which_role]
  before_action :has_role_check, only: [:which_role]

  def index
    @jobs = Job.includes(:company).order(:views_count).reverse
  end

  def which_role
  end

  private

    def has_role_check
      if current_user.has_any_role?
        flash[:alert] = "Sorry, you are not authorized to access this area!"
        redirect_to root_url
      end
    end
end
