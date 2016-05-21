class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.references :managed_twitter_account, foreign_key: true
      t.integer :twitter_id, limit: 8
      t.string :embed
      t.json :data

      t.timestamps
    end

    add_index :tweets, :twitter_id, :unique => true
  end
end
