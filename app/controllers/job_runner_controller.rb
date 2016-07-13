class JobRunnerController < ApplicationController
  protect_from_forgery :except => :perform_now

  def perform_now

    # job_name e.g. 'fetch_stream_metrics' for # FetchStreamMetricsJob

    job_name = params[:job]
    job = "#{job_name}_job".titleize.gsub(' ', '').constantize.new
    job.perform_now
  end
end
