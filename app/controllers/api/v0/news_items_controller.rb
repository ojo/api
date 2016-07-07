class Api::V0::NewsItemsController < ApplicationController
  include ::ActionController::Serialization
  skip_before_action :authenticate_user!, only: :index

  def index
    items = NewsItem.order(created_at: :desc).all
    render json: items, each_serializer: Api::V0::NewsItemSerializer
  end
end
