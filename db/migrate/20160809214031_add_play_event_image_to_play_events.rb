class AddPlayEventImageToPlayEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :play_events, :play_event_image, foreign_key: true
  end
end
