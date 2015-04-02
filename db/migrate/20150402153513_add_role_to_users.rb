class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: 0
    add_index :users, :role
  end
end
