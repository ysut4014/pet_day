class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :comment_id, null: false
      t.integer :like_id, null: false
      t.integer :follower_id, null: false
      t.string :action, null: false
      t.boolean :is_checked, null: false, default: false

      t.timestamps
    end

  end
end
