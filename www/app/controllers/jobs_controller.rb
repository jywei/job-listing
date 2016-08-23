class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_reserved_jobs, only: [:unfollow_job]
  before_action :log_impression, only: [:show], unique: [:session_hash]
  before_action :expiration_check, only: [:index]

  authorize_resource

  # GET /jobs
  def index
    @filterrific = initialize_filterrific(
      Job.unexpired.published,
      params[:filterrific],
      select_options: {
        sorted_by: Job.options_for_sorted_by,
        with_industry_id: Industry.options_for_select,
        with_category_id: Category.options_for_select,
        with_contract_type_id: ContractType.options_for_select,
        with_location_id: Location.options_for_select,
        with_salary_range_id: SalaryRange.options_for_select,
        with_company_id: Company.options_for_select
      },
      default_filter_params: {},
    ) or return
    @jobs = @filterrific.find.includes(:impressions, :company, :industry, :location, :category, :contract_type).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    # rescue ActiveRecord::RecordNotFound => e
    #   # There is an issue with the persisted param_set. Reset it.
    #   puts "Had to reset filter params: #{ e.message }"
    #   redirect_to(reset_filterrific_url(format: :html)) and return
    # end
  end

  # GET /jobs/1
  def show
    # @company = @job.company
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  def create
    @job = Job.new(job_params)
    #@job.company_id = Company.find_by(id: params[:company_id])
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def update
    # @job.company_id = Company.find(params[:company_id])
    @job.not_myanmar
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  def select_jobs
    @jobs = Job.find_by(category_id: params[:category])
    # binding.pry

    respond_to do |format|
      format.json { render json: @jobs }
    end
  end

  def favorite_job
    @reserved_job = ReservedJob.create(tracking_user_id: current_user.id, favorite_job_id: params[:id])
    render json: @reserved_job
  end

  def unfollow_job
    @reserved_job = @reserved_jobs.find_by(favorite_job_id: params[:id]).destroy
    render json: @reserved_job
  end

  private

    def set_reserved_jobs
      @reserved_jobs = current_user.reserved_jobs
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title,
                                  :description,
                                  :requirement,
                                  :apply_instruction,
                                  :location,
                                  :start_day,
                                  :professional_skill,
                                  :language_skills,
                                  :is_published,
                                  :category_id,
                                  :industry_id,
                                  :contract_type_id,
                                  :location_id,
                                  :salary_range_id,
                                  :company_id,
                                  :country_id)
    end

    def log_impression
      @job = Job.find(params[:id])
      impressionist(@job)
    end

    def expiration_check
      Job.where("start_day < ?", Date.today).update_all(status: 'expired')
    end

end
