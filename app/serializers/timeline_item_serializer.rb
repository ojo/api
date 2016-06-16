class TimelineItemSerializer < ActiveModel::Serializer
  attributes :id

  def id
    "#{object.subject_type.downcase}-#{object.subject_id}"
  end

  belongs_to :subject, polymorphic: :true
end
