class Admin::SeekerController < Admin::ApplicationController

  def index
    @resumes = Resume.all.includes(:user)
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])
    if @resume.update(resume_params)
      flash[:success] = "Update resume successfully"
      redirect_to admin_seeker_path
    else
      render :edit
    end
  end

  private

    def resume_params
      params.require(:resume).permit(:firstname, :lastname, :phone, :location_id, :birth, :employment_status_id, :cover)
    end
end
