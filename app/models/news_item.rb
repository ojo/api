class NewsItem < ApplicationRecord

  validates_presence_of :title, :body
  validate :category_permitted

  def category_permitted
    return if category.nil? or category.empty?
    errors.add(:category, "cannot literally be #{category}") if NewsCategory::RESERVED_NAMES.include? category
    errors.add(:category, "must exist in News Categories. (#{category} does not).") unless NewsCategory.pluck(:name).include? category
  end

  # states
  # ======
  # TODO send push notification on publish
  VALID_STATES = %w[draft published unpublished republished].freeze
  validates :state, inclusion: { in: VALID_STATES,
                                 message: '%{value} is not a valid state' }
  before_validation Proc.new { |o| o.state = 'draft' if state == nil }

  scope :published, -> { where(state: :published).or(where(state: :republished)) }

  # attachments
  # ===========
  has_attached_file :photo, {
    preserve_files: true,
    styles: {
      thumb: { geometry: '100x100#' },
      large: { geometry: '800x800#' },
    }
  }
  crop_attached_file :photo, aspect: '1:1'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_presence_of :photo

  after_save :compute_photo_dominant_color

  def compute_photo_dominant_color
    return unless changes[:photo_updated_at] != nil
    ComputeDominantColorJob.perform_later self, 'photo', 'photo_dominant_color'
  end
end
