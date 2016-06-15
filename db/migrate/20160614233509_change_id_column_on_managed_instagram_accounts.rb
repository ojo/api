class ChangeIdColumnOnManagedInstagramAccounts < ActiveRecord::Migration[5.0]
  def change
    change_column :managed_instagram_accounts, :id, :integer, limit: 8
  end
end
