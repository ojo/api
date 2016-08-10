class FetchPlayEventImageJob < ApplicationJob
  queue_as :default

  def perform play_event
    return if play_event.media_type != 'Song' # TODO throw?

    c = fetch_top_candidate generate_query_term(play_event)
    return if c == nil # TODO throw?

    pei = PlayEventImage.new
    pei.file = URI.parse get_appropriate_art(c)
    pei.save!

    play_event.image = pei
    play_event.save!
  end

  def generate_query_term play_event
    "#{play_event.artist} #{play_event.title}"
  end

  def fetch_top_candidate term, country = 'US', media_type = 'music'
    candidates = ITunesSearchAPI.search(:term => term, :country => country,
                                        :media => media_type)
    candidates.empty? ? nil : candidates[0]
  end

  def get_appropriate_art candidate
    # it seems that images are generated dynamically. request a very large one
    # in hopes of getting the source asset (which might be smaller than the
    # requested size)
    candidate['artworkUrl100'].gsub('100x100', '2000x2000')
  end
end
