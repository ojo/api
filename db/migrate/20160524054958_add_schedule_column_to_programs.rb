class AddScheduleColumnToPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :programs, :schedule, :text
  end
end
