class AddInstagramIdColumnToInstagramPost < ActiveRecord::Migration[5.0]
  def change
    add_column :instagram_posts, :instagram_id, :string
    add_index :instagram_posts, :instagram_id, :unique => true
  end
end
