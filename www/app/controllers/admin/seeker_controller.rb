class Admin::SeekerController < Admin::ApplicationController

  def index
    @resumes = Resume.all.includes(:user)
  end

  def edit
    @resume = Resume.find(params[:id])
  end
end
