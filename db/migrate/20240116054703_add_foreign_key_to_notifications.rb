class AddForeignKeyToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :notifications, :users, column: :visitor_id
    add_foreign_key :notifications, :users, column: :visited_id
    add_foreign_key :notifications, :comments
    add_foreign_key :notifications, :likes
    add_foreign_key :notifications, :users, column: :follower_id
    
  end
end
