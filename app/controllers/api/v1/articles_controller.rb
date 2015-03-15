class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate

  respond_to :json

  def index
    respond_with Article.all
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
      format.json { render json: @search_results }
    end
  end

  private

  def authenticate
    # authenticate_or_request_with_http_basic("Please authenticate with api") do |email, password|
    #   user = User.find_by(email: email)
    #   user.authenticate(password)
    # end
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(token: token)
    end
  end
end
