class ArticlesController < ApplicationController

  respond_to :html

  def index
    @articles = Article.all
    respond_with @articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def search
    @search_results = Article.where(
      "title LIKE ? or description LIKE ?",
      "%#{params[:search]}%",
      "%#{params[:search]}%"
    )
    respond_to do |format|
      format.html { @search_results }
    end
  end
end
