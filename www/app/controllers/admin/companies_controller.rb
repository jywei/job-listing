class Admin::CompaniesController < Admin::ApplicationController
  def index
    @companies = Company.all.includes(:jobs)
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:success] = "Update company successfully"
      redirect_to admin_companies_path
    else
      render :edit
    end
  end

  def getCompany
    @companies = Company.all.includes(:jobs)

    respond_to do |format|
      format.html { render :json => { :companies => @companies } }
    end
  end

  private

    def company_params
      params.require(:company).permit(:name, :tagline, :phone, :email, :address1, :address2, :about, :story, :welfare, :demand, :idea, :website, :facebook, :twitter, :ios, :android, :is_hiring, :image, :cover, :employee_range_id, :location_id, :country_id, :industry_id)
    end
end
