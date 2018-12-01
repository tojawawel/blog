class ArticlesController < ApplicationController
  def index
  end

  def new
    # @article = Article.new
  end

  def create
    render plain: params[:article].inspect
  end

end
