require 'httparty'

class Admin::OverviewController < Admin::BaseController
  def index
    h = TTRNWowza.new.connection_counts
    @info = ConnectionCountInfo.new h
  end
end

class ConnectionCountInfo
  class StreamInfo
    def initialize h
      @h = h
    end

    def name
      @h['Name']
    end

    def current_count
      @h['SessionsTotal']
    end
  end

  def initialize h
    @h = h
  end

  def current_count
    @h['WowzaStreamingEngine']['ConnectionsCurrent']
  end

  def streams
    streams = @h['WowzaStreamingEngine']['VHost']['Application']['ApplicationInstance']['Stream']
    streams.map do |s|
      StreamInfo.new s
    end
  end
end

class TTRNWowza
  include ::HTTParty
  base_uri 'fms.ttrn.org:8086'
  digest_auth ENV.fetch('TTRN_WOWZA_USER'), ENV.fetch('TTRN_WOWZA_PASSWORD')
  def connection_counts
    self.class.get('/connectioncounts')
  end
end
