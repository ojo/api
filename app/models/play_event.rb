class PlayEvent < ApplicationRecord
  belongs_to :station
  belongs_to :play_event_image
  alias_attribute :image, :play_event_image

  MEDIA_TYPES = ['Song', 'Spot']
end
