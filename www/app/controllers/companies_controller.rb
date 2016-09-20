class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :set_reserved_companies, only: [:unlike]
  before_action :log_impression, only: [:show], unique: [:session_hash]
  before_action :expiration_check, only: [:show]
  before_action :authorize_check, only: [:edit, :update]

  include ResumesHelper

  authorize_resource

  respond_to :html, :js

  def index
    @filterrific = initialize_filterrific(
      Company.all,
      params[:filterrific],
      select_options: {
        sorted_by: Company.options_for_sorted_by,
        with_industry_id: Industry.options_for_select,
        with_location_id: Location.options_for_select,
        with_employee_range_id: EmployeeRange.options_for_select
      },
      default_filter_params: {},
    ) or return
    @companies = @filterrific.find.includes(:impressions, :industry, :location, :employee_range).page(params[:page])

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

  def show
    @reserved_resumes = Company.find(params[:id]).reserved_resumes
  end

  def new
    @company = Company.new
    @company.user_id = current_user.id
  end

  def create
    @company = Company.new(company_params)
    @company.user_id = current_user.id
    if @company.save
      current_user.add_role :employer
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render @company
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  def save_to_favorites
    @reserved_company = ReservedCompany.create(following_user_id: current_user.id, favorite_company_id: params[:id])
    render json: @reserved_company
  end

  def unlike
    @reserved_company = @reserved_companies.find_by(favorite_company_id: params[:id]).destroy
    render json: @reserved_company
  end

  private

    def authorize_check
      unless @company == current_user.company
        flash[:danger] = "Sorry, you are not authorized to access this area!"
        redirect_to root_url
      end
    end

    def set_reserved_companies
      @reserved_companies = current_user.reserved_companies
    end

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name,
                                      :tagline,
                                      :phone,
                                      :email,
                                      :address1,
                                      :address2,
                                      :about,
                                      :story,
                                      :welfare,
                                      :demand,
                                      :idea,
                                      :website,
                                      :facebook,
                                      :twitter,
                                      :ios,
                                      :android,
                                      :is_hiring,
                                      :image,
                                      :cover,
                                      :employee_range_id,
                                      :location_id,
                                      :country_id,
                                      :industry_id)
    end

    def log_impression
      @company = Company.find(params[:id])
      impressionist(@company)
    end

    def expiration_check
      Job.where("start_day < ?", Date.today).update_all(status: 'expired')
    end
end
