class CommentsController < ApplicationController
  before_action :find_article
  before_action :find_comment, only: [:destroy, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user = current_user
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    if @comment.save
      flash[:notice] = "Created succesfully!"
      redirect_to article_path(@comment.article)
    else
      render 'articles/show'
    end

  end

  def destroy
    @comment.destroy
    flash[:notice] = "Destroyed succesfully!"
    redirect_to article_path(@comment.article)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:alert] = "Updated succesfully!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :article_id)
  end

  def find_article
    @article = Article.published.find(params[:article_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
