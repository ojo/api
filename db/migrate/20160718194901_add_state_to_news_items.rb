class AddStateToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :state, :string, default: 'draft'
  end
end
