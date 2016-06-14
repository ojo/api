class AddPublishedColumnToManagedTwitterAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :managed_twitter_accounts, :published, :boolean
  end
end
