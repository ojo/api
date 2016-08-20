class AddPriorityToNewsCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :news_categories, :priority, :integer
    add_index :news_categories, :priority, unique: true
  end
end
