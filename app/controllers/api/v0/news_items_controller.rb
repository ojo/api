class Api::V0::NewsItemsController < Api::V0::BaseController
  include ::ActionController::Serialization

  def index
    items = NewsItem.order(created_at: :desc).all
    render json: items, each_serializer: Api::V0::NewsItemSerializer
  end
end
