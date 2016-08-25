class Admin::JobFilterController < Admin::ApplicationController
  def index
    # @categories = Category.all
  end

  def getData
    @categories = Category.all
    @industries = Industry.all
    @contracttypes = ContractType.all
    @locations = Location.all
    @salaryranges = SalaryRange.all

    respond_to do |format|
      format.json { render :json => { :categories => @categories,
                                      :industries => @industries,
                                      :contracttypes => @contracttypes,
                                      :locations => @locations,
                                      :salaryranges => @salaryranges } }
    end
  end

  def addFilter
    if params[:filtername] == "Indu"
      @industry = Industry.create!(name: params[:name])
    elsif params[:filtername] == "Cate"
      @industry = Category.create!(name: params[:name])
    elsif params[:filtername] == "Cont"
      @industry = ContractType.create!(name: params[:name])
    elsif params[:filtername] == "Loca"
      @industry = Location.create!(name: params[:name])
    elsif params[:filtername] == "Sala"
      @industry = SalaryRange.create!(range: params[:name])
    end

    respond_to do |format|
      format.json { render :json => @industry }
    end
  end

  def deleFilter
    if params[:name] == "Indu"
      boolean = Industry.find(params[:id]).delete
    elsif params[:name] == "Cate"
      boolean = Category.find(params[:id]).delete
    elsif params[:name] == "Cont"
      boolean = ContractType.find(params[:id]).delete
    elsif params[:name] == "Loca"
      boolean = Location.find(params[:id]).delete
    elsif params[:name] == "Sala"
      boolean = SalaryRange.find(params[:id]).delete
    end

    respond_to do |format|
      format.json { render :json => boolean }
    end
  end
end
