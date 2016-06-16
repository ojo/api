class TimelineController < ApplicationController
  include ::ActionController::Serialization
  skip_before_action :authenticate_user!, only: :index

  def index
    opts = {}
    opts[:limit] = params[:limit].to_i if params[:limit]
    subjects = Timeline.all opts
    items = subjects.map do |i|
      TimelineItem.new(subject: i)
    end
    render json: items, include: 'subject'
  end
end
