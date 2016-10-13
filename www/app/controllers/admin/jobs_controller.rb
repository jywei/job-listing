class Admin::JobsController < Admin::ApplicationController

  def index
    @jobs = Job.all.includes(:category, :industry, :contract_type, :location, :salary_range, :company, :country)
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Update job successfully"
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end

  private

    def job_params
      params.require(:job).permit(:title, :description, :requirement, :apply_instruction,
                                  :start_day, :professional_skill, :language_skills, :is_published,
                                  :category_id, :industry_id, :contract_type_id, :location_id,
                                  :salary_range_id, :country_id)
    end
end
