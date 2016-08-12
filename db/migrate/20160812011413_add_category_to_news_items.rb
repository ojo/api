class AddCategoryToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :category, :string
  end
end
