class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :name

      t.timestamps
    end
    add_index :stations, :name, unique: true
  end
end
