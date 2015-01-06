class ChangeRoleColumn < ActiveRecord::Migration
  def change
    rename_column :users, :role, :admin
    change_column :users, :admin, :boolean, default: false
  end
end
