class CreateManagedTwitterAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :managed_twitter_accounts do |t|
      t.string :username

      t.timestamps
    end
    add_index :managed_twitter_accounts, :username, :unique => true
  end
end
