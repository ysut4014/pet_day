class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.bigint :visitor_id, null: false
      t.bigint :visited_id, null: false
      t.bigint :comment_id, null: false
      t.bigint :like_id, null: false
      t.bigint :follower_id, null: false
      t.string :action, null: false
      t.boolean :is_checked, null: false, default: false

      t.timestamps
    end

  end
end
