class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :log_impression, only: [:show], unique: [:session_hash]
  authorize_resource

  # GET /jobs
  def index
    @filterrific = initialize_filterrific(
      Job,
      params[:filterrific],
      select_options: {
        sorted_by: Job.options_for_sorted_by,
        with_industry_id: Industry.options_for_select,
        with_category_id: Category.options_for_select,
        with_contract_type_id: ContractType.options_for_select,
        with_location_id: Location.options_for_select,
        with_salary_range_id: SalaryRange.options_for_select
      }
    ) or return
    @jobs = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    # rescue ActiveRecord::RecordNotFound => e
    #   # There is an issue with the persisted param_set. Reset it.
    #   puts "Had to reset filterrific params: #{ e.message }"
    #   redirect_to(reset_filterrific_url(format: :html)) and return
    # end
  end

  # GET /jobs/1
  def show
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
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def update
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

  private
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
                                  :is_published,
                                  :category_id,
                                  :industry_id,
                                  :contract_type_id,
                                  :location_id,
                                  :salary_range_id)
    end

    def log_impression
      @job = Job.find(params[:id])
      impressionist(@job)
    end

end
