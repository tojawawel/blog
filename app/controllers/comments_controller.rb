class CommentsController < ApplicationController
before_action :find_article
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
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@comment.article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

end


# @article = Article.find(params[:article_id])
# @comment = @article.comments.new(comment_params)

# end
