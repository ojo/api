class AddAttachmentFileToPlayEventImages < ActiveRecord::Migration
  def self.up
    change_table :play_event_images do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :play_event_images, :file
  end
end
