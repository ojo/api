class JobRunnerController < ApplicationController
  protect_from_forgery :except => :perform_now

  def perform_now
    return head(:unauthorized) if ENV['DISABLE_SQS_CONSUMER']

    job_name = request.headers['X-Aws-Sqsd-Taskname']
    job = job_name.constantize.new
    job.perform_now
    return head(:ok)
  end
end
