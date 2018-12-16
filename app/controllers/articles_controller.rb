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
      flash[:notice] = "Created succesfully!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
  end

  def edit
    unless @article.user == current_user || current_user.admin?
      flash[:alert] = "You're not able to edit this!"
      redirect_to articles_path
    end
  end

  def update
    @article.user = current_user
    if @article.update(article_params)
      flash[:notice] = "Updated succesfully!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Destroyed succesfully!"
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
