class ChangeFollowerIdToAllowNullInNotifications < ActiveRecord::Migration[6.1] # Or use your Rails version
  def change
    change_column_null :notifications, :follower_id, true
  end
end
