class AddStrapheadToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :straphead, :string
  end
end
