class CreateStreamMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :stream_metrics do |t|
      t.string :name
      t.integer :connection_count

      t.timestamps
    end
  end
end
