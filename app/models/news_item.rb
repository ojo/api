class NewsItem < ApplicationRecord
  has_attached_file :photo, {
    preserve_files: true,
    url: ':hash.:extension',
    hash_secret: ENV.fetch('SECRET_KEY_BASE'),
    styles: {
      thumb: { geometry: '100x100#' },
      large: { geometry: '800x800#' },
    }
  }
  crop_attached_file :photo, aspect: '1:1'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  validates_presence_of :title, :body, :photo
end
