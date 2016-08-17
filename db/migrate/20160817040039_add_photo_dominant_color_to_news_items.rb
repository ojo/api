class AddPhotoDominantColorToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :photo_dominant_color, :string
  end
end
