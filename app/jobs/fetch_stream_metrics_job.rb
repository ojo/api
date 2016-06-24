require 'httparty'

class FetchStreamMetricsJob < ApplicationJob
  NUM_SECONDS_TO_WAIT = 0

  def perform *args
    StreamMetric.with_advisory_lock(self.class.name, NUM_SECONDS_TO_WAIT) do
      StreamMetric.transaction do
        resp = TTRNWowza.new.connection_counts

        m = StreamMetric.new name: StreamMetric::AGGREGATE_KEY
        m.connection_count = resp['WowzaStreamingEngine']['VHost']['ConnectionsCurrent']
        m.save!

        instances = resp['WowzaStreamingEngine']['VHost']['Application']['ApplicationInstance']

        streams = nil
        if instances.is_a? Array
          instances.each do |instance|
            if instance['Name'] == '_definst_'
              streams = instance['Stream']
            end
          end
        elsif instances.is_a? Hash
          streams = instances['Stream']
        end

        streams.each do |s|
          m = StreamMetric.new
          m.name = s['Name']
          m.connection_count = s['SessionsTotal']
          m.save!
        end
      end
    end
  end
end

class TTRNWowza
  include HTTParty
  base_uri 'fms.ttrn.org:8086'
  digest_auth ENV.fetch('TTRN_WOWZA_USER'), ENV.fetch('TTRN_WOWZA_PASSWORD')

  def connection_counts
    self.class.get('/connectioncounts')
  end
end
