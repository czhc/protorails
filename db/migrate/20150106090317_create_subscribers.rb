class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id, null: false
      t.string :email, null: false
      t.string :activation_code
      t.datetime :activated_at
      t.integer :state, default: 0
      t.datetime :unsubscribed_at
    end
  end
end
