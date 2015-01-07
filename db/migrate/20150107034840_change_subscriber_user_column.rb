class ChangeSubscriberUserColumn < ActiveRecord::Migration
  def change
    change_column :subscribers, :user_id, :integer, null: true
  end
end
