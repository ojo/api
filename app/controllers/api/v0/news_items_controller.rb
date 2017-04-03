class Api::V0::NewsItemsController < Api::V0::BaseController
  include ::ActionController::Serialization

  def index
    q = NewsItem.published.order(created_at: :desc)

    if params[:before] or params[:after] then
      key = params[:by_date] ? 'created_at' : 'id'
      if params[:before] then
        value = params[:before]
        comparator = "#{key} < ?"
      end
      if params[:after] then
        value = params[:after]
        comparator = "#{key} > ?"
      end
      q = q.where(comparator, value)
    end

    if params[:limit] then
      q = q.limit(params[:limit])
    end

    render json: q.all, each_serializer: Api::V0::NewsItemSerializer
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
