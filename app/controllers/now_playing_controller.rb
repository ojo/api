class NowPlayingController < ApplicationController
  protect_from_forgery :except => [:create] # uses API auth
  skip_before_action :authenticate_user!, only: :create

  def create

    if params[:token] != "foo" # TODO get token
      return head :unauthorized
    end

    begin
      doc = Nokogiri::XML(params[:file]) do |config|
        config.strict
      end
    rescue Nokogiri::XML::SyntaxError
      return head :bad_request
    end

    params[:file].rewind
    @station = station_for_xml(params[:name], doc)
    # TODO decide which station this pertains to, based on name and contents
    render json: params
  end

  private
  def station_for_xml name, doc
    if name == 'foo'
      type = doc.xpath('//Playing/item').attribute('type')

      if type == 'MUS'
        artist = doc.xpath('//Playing/item//Artist')[0].content
        title = doc.xpath('//Playing/item//SongTitle')[0].content
        started_at = DateTime.strptime(doc.xpath('//Playing/item/StartedAt')[0].content)
        length_secs = doc.xpath('//Playing/item//Length')[0].content.to_i
      end
    elsif name == 'foob'
      puts doc
    end
  end
end
