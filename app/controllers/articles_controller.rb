class ArticlesController < ApplicationController
  before_action :set_article, only:[:show,:edit,:update,:destroy]
  before_action :authenticate_user!, except:[:index, :show]
  before_action :authorize_article, only:[:edit, :update, :destroy]


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
    @comment = Comment.new
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end
      format.json do
        sleep (rand(100)/10)
        render json: {
          id: @article.id,
          title: @article.title,
          text: @article.text,
          views_count: @article.views_count,
          likes_count: @article.likes.count,
          comments_count: @article.comments.count}
      end
    end
  end

  def edit
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

  def authorize_article
    unless @article.user == current_user || current_user.admin?
      flash[:alert] = "You're not able to edit this!"
      redirect_to articles_path
    end
  end

  def article_params
    article_params = params.require(:article).permit(:title, :text, :tags)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
