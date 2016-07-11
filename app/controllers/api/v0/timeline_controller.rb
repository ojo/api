class Api::V0::TimelineController < Api::V0::BaseController
  include ::ActionController::Serialization

  def index
    opts = {}
    opts[:limit] = params[:limit].to_i if params[:limit].present?
    subjects = Timeline.all opts
    items = subjects.map do |i|
      TimelineItem.new(subject: i)
    end
    render json: items, include: 'subject'
  end
end
