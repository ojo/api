class Api::V0::NewsCategorySerializer < ActiveModel::Serializer
  cache key: 'news_category'
  attributes :id, :name
end
