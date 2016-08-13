require 'maybe' # used in view

class Admin::MetricsController < Admin::BaseController
  def index
    authorize! :read, StreamMetric
  end

  def ttt
    authorize! :read, StreamMetric
    @stream_metric_names = StreamMetric.names.sort
    @time = Time.now.in_time_zone
  end

  def peak_times
    authorize! :read, StreamMetric
    @stream_metric_names = StreamMetric.names.sort
  end
end
