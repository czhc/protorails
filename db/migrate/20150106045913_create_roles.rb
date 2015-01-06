class CreateRoles < ActiveRecord::Migration
  def up
    add_column :users, :role, :integer, default: 0 unless column_exists? :users, :role
    add_index :users, :role unless index_exists? :users, :role
  end

  def down
    remove_column :users, :role
  end
end
