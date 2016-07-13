class ApplicationJob < ActiveJob::Base
  queue_as :ttrnq
end
