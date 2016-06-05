class CreateInstagramPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :instagram_posts do |t|
      t.json :data
      t.references :managed_instagram_account, foreign_key: true

      t.timestamps
    end
  end
end
