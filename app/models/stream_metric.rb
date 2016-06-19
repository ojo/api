class StreamMetric < ApplicationRecord

  # AGGREGATE_KEY is the name used for aggregate metrics 
  AGGREGATE_KEY = 'all'

  def self.metric_at(d, t, opts={})
    name = opts[:name] ? opts[:name] : AGGREGATE_KEY
    secs = opts[:secs] ? opts[:secs] : 60
    datetime = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
    range = datetime.advance(seconds: -secs)..datetime.advance(seconds: secs)

    b4 = self.where(created_at: range).where(name: name).where("created_at <= ?", datetime).order("created_at DESC").first
    after = self.where(created_at: range).where(name: name).where("created_at >= ?", datetime).order("created_at ASC").first

    return nil if b4 == nil and after == nil
    return b4 if after == nil
    return after if b4 == nil
    closest = (datetime - b4.created_at.to_datetime).abs < (after.created_at.to_datetime - datetime).abs ? b4 : after
    return closest
  end

  def self.peak date, opts={}
    name = opts[:name] ? opts[:name] : AGGREGATE_KEY
    b = date.beginning_of_day
    e = date.end_of_day
    self.where(name: name).where(created_at: b..e).order(connection_count: :desc).first
  end

  def self.names
    self.group(:name).pluck(:name)
  end
end
