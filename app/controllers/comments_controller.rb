class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to articles_path(@comment.article)
  end


  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end

end


# @article = Article.find(params[:article_id])
# @comment = @article.comments.new(comment_params)
# if @comment.save
#   redirect_to article_path(@article)
# else
#   render 'new'
# end
