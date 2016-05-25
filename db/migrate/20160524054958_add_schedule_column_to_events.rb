class AddScheduleColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :schedule, :text
  end
end
