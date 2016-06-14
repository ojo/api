class AddPublishedColumnToManagedInstagramAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :managed_instagram_accounts, :published, :boolean
  end
end
