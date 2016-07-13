class NewsItem < ApplicationRecord
  has_attached_file :photo, styles: {
    thumb: { geometry: '100x100#', processors: [:papercrop] },
    large: { geometry: '800x800#', processors: [:papercrop] },
  }
  crop_attached_file :photo, aspect: '1:1'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
