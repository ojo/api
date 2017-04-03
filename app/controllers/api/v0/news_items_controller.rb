class Api::V0::NewsItemsController < Api::V0::BaseController
  include ::ActionController::Serialization

  def index

    key = params[:by_date] ? 'created_at' : 'id'

    if params[:before] then
      comparator = "#{key} < ?"
    elsif params[:after] then
      comparator = "#{key} > ?"
    end

    time = params[:before] or params[:after]
    paginated = lambda { time }

    limit = params[:limit]
    limited = lambda { limit }

    q = NewsItem.published.order(created_at: :desc)
    if paginated then
      q = q.where(comparator, time)
    end
    if limited then
      q = q.limit(limit)
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
