class Api::V0::NewsItemSerializer < ActiveModel::Serializer
  cache key: 'news_item'
  attributes :id, :title, :subtitle, :body, :created_at, :photo_thumb_url,
    :photo_url

  def photo_thumb_url
    object.photo.url(:thumb)
  end

  def photo_url
    object.photo.url
  end
end
