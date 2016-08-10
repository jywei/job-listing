class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :log_impression, only: [:show], unique: [:session_hash]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
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
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name,
                                      :tagline,
                                      :phone,
                                      :email,
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
                                      :employee_range_id)
    end

    def log_impression
      @company = Company.find(params[:id])
      impressionist(@company)
    end
end
