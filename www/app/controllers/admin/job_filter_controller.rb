class Admin::JobFilterController < Admin::ApplicationController
  def index
    # @categories = Category.all
  end

  def getData
    @categories = Category.all

    respond_to do |format|
      format.json { render :json => @categories }
    end
  end

  def addCate
    @category = Category.create!(name: params[:name])
    # binding.pry
    respond_to do |format|
      format.json { render :json => @category }
    end
  end

  def deleCate
    boolean = Category.find(params[:id]).delete

    respond_to do |format|
      format.json { render :json => boolean }
    end
    # redirect_to admin_categories_path
    # flash[:success] = "Delete category success"
  end
end
