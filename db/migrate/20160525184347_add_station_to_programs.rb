class AddStationToPrograms < ActiveRecord::Migration[5.0]
  def change
    add_reference :programs, :station, foreign_key: true
  end
end
