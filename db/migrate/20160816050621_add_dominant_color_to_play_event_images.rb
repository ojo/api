class AddDominantColorToPlayEventImages < ActiveRecord::Migration[5.0]
  def change
    add_column :play_event_images, :dominant_color, :string
  end
end
