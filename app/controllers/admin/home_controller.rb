class Admin::HomeController < Admin::BaseController
  def index
    authorize! :go, :home

    songs_played_by_day = PlayEvent.where(media_type: 'Song').group_by_day(:created_at).count
    without_art_by_day = PlayEvent.where(media_type: 'Song').where(play_event_image_id: nil).group_by_day(:created_at).count

    @percentage_with_art_by_day = {}
    songs_played_by_day.each do |date, count|
      num_without_art = without_art_by_day[date]
      next if num_without_art == nil
      @percentage_with_art_by_day[date] = num_without_art / count
    end
  end
end
