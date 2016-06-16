class RefreshTimelineJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Timeline.index
  end
end
