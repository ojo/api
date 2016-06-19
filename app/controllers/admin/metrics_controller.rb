require 'maybe' # used in view

class Admin::MetricsController < Admin::BaseController
  def ttt
    @stream_metric_names = StreamMetric.names
    @time = Time.now
  end

  def peak_times
    @stream_metric_names = StreamMetric.names
  end
end
