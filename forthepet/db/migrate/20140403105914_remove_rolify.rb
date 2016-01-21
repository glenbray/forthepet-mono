class RemoveRolify < ActiveRecord::Migration
  def change
    remove_index :roles, name: 'index_roles_on_name_and_resource_type_and_resource_id'
    remove_index :roles, name: 'index_roles_on_name'
    drop_table :roles

    remove_index :users_roles, name: 'index_users_roles_on_user_id_and_role_id'
    drop_table :users_roles
  end
end
