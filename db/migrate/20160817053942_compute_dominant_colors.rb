class ComputeDominantColors < ActiveRecord::Migration[5.0]
  def up
    NewsItem.where(photo_dominant_color: nil).each do |item|
      ComputeDominantColorJob.perform_later item, 'photo', 'photo_dominant_color'
    end
    PlayEventImage.where(dominant_color: nil).each do |image|
      ComputeDominantColorJob.perform_later image, 'file', 'dominant_color'
    end
  end
end
