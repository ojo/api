class Api::V0::NewsItemsController < Api::V0::BaseController
  include ::ActionController::Serialization

  def index
    items = NewsItem.published.order(created_at: :desc).all
    render json: items, each_serializer: Api::V0::NewsItemSerializer
  end

  def show
    item = NewsItem.published.find(params[:id])
    render json: item, serializer: Api::V0::NewsItemSerializer
  end

  def categories
    serializer = if format_jsonapi then Api::V0::NewsCategorySerializer else nil end
    items = NewsCategory.select(:id, :name).order(name: :asc).all
    render json: items, each_serialilzer: serializer
  end

  private
  def format_jsonapi
    params[:format] == 'jsonapi'
  end
end
