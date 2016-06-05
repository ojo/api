class CreateManagedInstagramAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :managed_instagram_accounts do |t|
      t.string :username
      t.string :token

      t.timestamps
    end
  end
end
