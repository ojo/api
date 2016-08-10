class CreatePlayEventImages < ActiveRecord::Migration[5.0]
  def change
    create_table :play_event_images do |t|
      t.string :name

      t.timestamps
    end
    add_index :play_event_images, :name, unique: true
  end
end
