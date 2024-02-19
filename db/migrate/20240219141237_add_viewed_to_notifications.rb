# db/migrate/YYYYMMDDHHMMSS_add_viewed_to_notifications.rb
class AddViewedToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :viewed, :boolean, default: false
  end
end
