class Api::V0::NewsItemSerializer < ActiveModel::Serializer
  cache key: 'news_item'
  attributes :id, :title, :subtitle, :body, :created_at, :photo_thumb_url,
    :photo_dominant_color,
    :photo_url, :straphead, :photo_caption, :category

  def photo_thumb_url
    object.photo.url(:thumb)
  end

  def created_at
    object.created_at.to_i
  end

  def photo_url
    object.photo.url
  end
end
