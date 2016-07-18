class AddRolesUsersUniquenessConstraint < ActiveRecord::Migration[5.0]
  def change
    add_index :roles_users, [ :role_id, :user_id ], :unique => true, :name => 'by_user_and_role'
  end
end
