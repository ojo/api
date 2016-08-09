class AddTagToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :tag, :string
    add_index :stations, :tag, unique: true
  end
end
