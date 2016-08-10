class Api::V0::PlayEventImagesController < Api::V0::BaseController
  before_action :restrict_access, only: [:create]

  def create
    # assumes name is a hash
    image = PlayEventImage.find_or_create_by(name: params['name']) do |i|
      i.file = params['image']
    end
    return head 500 if not image.persisted?
    head 200
  end
end
