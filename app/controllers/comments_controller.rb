class CommentsController < ApplicationController
  before_action :find_article
  before_action :find_comment, only: [:destroy, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    if @comment.save
      redirect_to article_path(@comment.article)
    else
      render 'articles/show'
    end

  end

  def destroy
    @comment.destroy
    redirect_to article_path(@comment.article)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
