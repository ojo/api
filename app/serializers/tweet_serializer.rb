class TweetSerializer < ActiveModel::Serializer
  attributes :id, :data, :embed

  def data
    json
  end

  private
  def json
    @json ||= JSON.load(object.data)
  end
end
