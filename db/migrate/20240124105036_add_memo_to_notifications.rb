class AddMemoToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :memo, :text
  end
end