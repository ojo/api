class PlayEventImage < ApplicationRecord
  has_many :play_events

  # paperclip
  has_attached_file :file, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>", mini: "50x50>" }
  validates_attachment_content_type :file, content_type: [/\Aimage\/.*\Z/]
  before_post_process on: :create do
    if file_content_type == 'application/octet-stream'
      mime_type = MIME::Types.type_for(file_file_name)
      self.file_content_type = mime_type.first.to_s if mime_type.first
    end
  end

  after_save :compute_dominant_color

  def compute_dominant_color
    return unless changes[:file_updated_at] != nil
    ComputeDominantColorJob.perform_later self, 'file', 'dominant_color'
  end
end
