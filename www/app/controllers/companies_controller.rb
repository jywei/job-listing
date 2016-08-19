class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :set_reserved_companies, only: [:show, :unfollow]
  before_action :log_impression, only: [:show], unique: [:session_hash]
  before_action :expiration_check, only: [:show]

  respond_to :html, :js

  def index
    @companies = Company.all
  end

  def show
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

  def unfollow
    @reserved_company = @reserved_companies.find_by(favorite_company_id: params[:id]).destroy
    render json: @reserved_company
  end

  private

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
