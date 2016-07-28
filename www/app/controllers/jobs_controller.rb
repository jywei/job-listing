class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  def index
    # if params[:category].blank?
    #   @jobs = Job.all.published.order("created_at DESC")
    # else
    #   @category_id = Category.find_by(name: params[:category]).id
    #   @jobs = Job.where(category_id: @category_id).published.order("created_at DESC")
    # end

    if params[:category].blank? && params[:industry].blank?
      @jobs = Job.all.published.order("created_at DESC")
    else
      @category = Category.find_by(name: params[:category]) ? Category.find_by(name: params[:category]) : nil
      @industry = Industry.find_by(name: params[:industry]) ? Industry.find_by(name: params[:industry]) : nil
      # binding.pry
      @jobs = Job.by_category_and_industry(@category, @industry).published.order("created_at DESC")
    end
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
                                  :professional_skill ,
                                  :is_published,
                                  :category_id,
                                  :industry_id)
    end

end
