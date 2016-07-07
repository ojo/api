class AddAttachmentPhotoToNewsItems < ActiveRecord::Migration
  def self.up
    change_table :news_items do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :news_items, :photo
  end
end
