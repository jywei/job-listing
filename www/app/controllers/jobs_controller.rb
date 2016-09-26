class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_reserved_jobs, only: [:unfollow_job]
  # before_action :log_impression, only: [:show], unique: [:session_hash]
  before_action :expiration_check, only: [:index, :update]
  before_action :check_cover_letter_is_available, only: [:new_cover_letter, :cover_letter]

  authorize_resource :job

  # GET /jobs
  def index
    if params[:is_from_root]
      location_id_array = Array.new
      location_id_array.push(params[:filterrific][:with_location_id], "")
      params[:filterrific][:with_location_id] = location_id_array
    end

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
    new_views_count = @job.views_count + 1
    @job.update_attributes(views_count: new_views_count)
    @preferred_candidate = PreferredCandidate.new
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
    @job.company_id = current_user.company.id
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def update
    # @job.company_id = Company.find(params[:company_id])
    @job.company_id = current_user.company.id
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

  def new_cover_letter
    @user = current_user
    @job = Job.find(params[:id])
    @cover_letter = CoverLetter.new
  end

  def cover_letter
    @user = current_user
    @cover_letter = CoverLetter.new(cover_letter_params)
    @cover_letter.resume_id = @user.resume.id
    @cover_letter.job_id = params[:cover_letter][:id]
    if @cover_letter.save
      Notifier.cover_letter_contact(@cover_letter).deliver_now
      redirect_to dashboard_path, notice: "Cover letter successfully submit"
    else
      render :new_cover_letter
    end
  end

  def show_cover_letter
    @cover_letter = CoverLetter.find(params[:id])
    if current_user
      if current_user.company == @cover_letter.job.company || current_user.resume == @cover_letter.resume
        @cover_letter.update_attributes(is_read: true) if @cover_letter.job.company == current_user.company
      else
        flash[:danger] = "Sorry, you are not authorized to access this area!"
        redirect_to root_url
      end
    else
      flash[:danger] = "Sorry, you are not authorized to access this area!"
      redirect_to root_url
    end
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

    def check_cover_letter_is_available
      if params[:cover_letter]
        if !Job.find(params[:cover_letter][:id]).is_published || !(Job.find(params[:cover_letter][:id]).start_day >= Date.today)
          redirect_to root_path
          flash[:alert] = "Sorry, you are not authorized to access this area!"
        end
      else
        if !Job.find(params[:id]).is_published || !(Job.find(params[:id]).start_day >= Date.today)
          redirect_to root_path
          flash[:alert] = "Sorry, you are not authorized to access this area!"
        end
      end
    end

    def set_reserved_jobs
      @reserved_jobs = current_user.reserved_jobs
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def cover_letter_params
      params.require(:cover_letter).permit(:description)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description, :requirement, :apply_instruction, :location,
                                  :start_day, :professional_skill, :language_skills, :is_published,
                                  :category_id, :industry_id, :contract_type_id, :location_id,
                                  :salary_range_id, :country_id)
    end

    def log_impression
      @job = Job.find(params[:id])
      impressionist(@job)
    end

    def expiration_check
      Job.where("start_day < ?", Date.today).update_all(status: 'expired')
      Job.where("start_day >= ?", Date.today).update_all(status: nil )
    end

end
