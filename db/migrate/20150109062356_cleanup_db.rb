class CleanupDb < ActiveRecord::Migration
  def change
    drop_table :comments if table_exists? :comments
    drop_table :articles if table_exists? :articles
  end
end
