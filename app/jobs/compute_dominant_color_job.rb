class ComputeDominantColorJob < ApplicationJob
  def perform model, photo_attr, color_attr
    colors = Miro::DominantColors.new model.send(photo_attr).url
    model.send("#{color_attr}=", colors.to_hex[0])
    model.save!
  end
end
