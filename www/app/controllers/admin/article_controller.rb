class Admin::ArticleController < Admin::ApplicationController

  def index
    @article  = Article.new
    @articles = Article.all
  end

  def create_article
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Create article successfully"
      @articles = Article.all
      redirect_to admin_article_path
    else
      @articles = Article.all
      render :index
    end
  end

  def delete
    Article.find(params[:id]).delete
    flash[:success] = "Delete article successfully"
    redirect_to admin_article_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :subtitle, :text, :author, :cover)
    end
end
