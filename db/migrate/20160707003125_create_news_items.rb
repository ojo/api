class CreateNewsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :news_items do |t|
      t.string :title
      t.string :subtitle
      t.text :body

      t.timestamps
    end
  end
end
