class TimelineItem 
  extend ActiveModel::Naming
  include ActiveModel::Serialization

  def initialize opts={}
    @subject = opts[:subject]
  end

  def subject_type
    @subject.class.name
  end

  def subject_id
    @subject.id
  end

  def subject
    @subject
  end

  def posted_at
    # TODO
    return i.subject.posted_at if i.subject_type == 'tweet'
  end
end
