class ArticlesController < ApplicationController
  def index
  end

  def new
    # @article = Article.new
  end

  def create
    article_params = params.require(:article).permit(:title, :text)
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id])
  end

end
