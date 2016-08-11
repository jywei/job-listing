class Admin::CompaniesController < Admin::ApplicationController
  def index
  end

  def getCompany
    @companies = Company.all.includes(:jobs)

    respond_to do |format|
      format.html { render :json => { :companies => @companies } }
    end
  end
end
