class Admin::CategoriesController < Admin::ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path
      flash[:success] = "Create category success"
    else
      redirect_to admin_categories_path
      flash[:danger] = "Create category failed"
    end
  end

  def destroy
    Category.find(params[:id]).delete
    redirect_to admin_categories_path
    flash[:success] = "Delete category success"
  end

  private

    def category_params
      binding.pry
      params.require(:category).permit(:name)
    end
end
