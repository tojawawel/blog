class MarksController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    article = Article.find(params[:article_id])
    mark = Mark.new(mark_params)
    mark.comment = @comment
    mark.user_id = current_user.id
    mark.save
    redirect_to article_path(@comment.article)
  end

  def destroy
    mark = Mark.find(params[:id])
    mark.destroy
    redirect_to article_path(mark.comment.article)
  end
end

private
def mark_params
  mark_params = params.require(:mark).permit(:mark)
end
