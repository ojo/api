class ChangeManagedInstagramAccountIdColumnOnInstagramPost < ActiveRecord::Migration[5.0]
  def change
    change_column :instagram_posts, :managed_instagram_account_id, :integer, limit: 8
  end
end
