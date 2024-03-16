class AddForeignKeyToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :notifications, :users, column: :visitor_id
    add_foreign_key :notifications, :users, column: :visited_id
    add_foreign_key :notifications, :comments
   # add_foreign_key :notifications, :likes  # 修正点: likes テーブルが存在することを前提として外部キー制約を追加
  end
end
