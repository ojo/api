class CheckForRecentPlayEventsJob < ApplicationJob
  def perform(*args)
    time_of_last_event = PlayEvent.last.created_at
    if now - time_of_last_event > 15.minutes
      Admin::NoNewPlayEventsMailer.since(time_of_last_event).deliver_now
    end
  end
end
