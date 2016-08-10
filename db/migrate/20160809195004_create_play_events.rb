class CreatePlayEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :play_events do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.integer :length_in_secs
      t.string :media_type
      t.references :station, foreign_key: true
      t.integer :nexgen_id

      t.timestamps
    end
  end
end
