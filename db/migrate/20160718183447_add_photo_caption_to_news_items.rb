class AddPhotoCaptionToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :photo_caption, :string
  end
end
