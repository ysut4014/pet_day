# db/migrate/[timestamp]_change_notifications_table.rb

class ChangeNotificationsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :notifications do |t|
      t.remove :post_id
      t.remove :follower_id
      t.remove :viewed

      t.integer :like_id unless column_exists?(:notifications, :like_id)
      t.boolean :is_checked, default: false, null: false unless column_exists?(:notifications, :is_checked)
      t.text :memo unless column_exists?(:notifications, :memo)
    end
  end
end
