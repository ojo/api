class InstagramPostSerializer < ActiveModel::Serializer
  attributes :id, :data

  def data
    json
  end

  private
  def json
    @json ||= JSON.load(object.data)
  end
end
