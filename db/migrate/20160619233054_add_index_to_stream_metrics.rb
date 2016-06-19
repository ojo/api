class AddIndexToStreamMetrics < ActiveRecord::Migration[5.0]
  def change
    add_index :stream_metrics, :created_at
    add_index :stream_metrics, :name
  end
end
