class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :micropost_id
      t.integer :passive_user_id
      t.integer :active_user_id
      t.string :activity

      t.timestamps
    end
    add_index :notifications, [:passive_user_id, :created_at]
  end
end
