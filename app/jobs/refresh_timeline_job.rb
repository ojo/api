class RefreshTimelineJob < ApplicationJob
  def perform(*args)
    Timeline.index
  end
end
