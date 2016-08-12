class CreateNewsCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :news_categories do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
    add_index :news_categories, :name, unique: true
  end
end
