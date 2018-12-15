class ArticlesController < ApplicationController
  before_action :set_article, only:[:show,:edit,:update,:destroy]

  def index
    @articles = Article.all.order(:id)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
  end

  def edit
  end

  def update
    @article.user = current_user
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    article_params = params.require(:article).permit(:title, :text, :tags)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
