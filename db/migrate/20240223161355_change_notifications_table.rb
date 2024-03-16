class ChangeNotificationsTable < ActiveRecord::Migration[6.1]
  def change
    # カラムを明示的に追加する
    add_column :notifications, :new_column_name, :data_type

    # 既存のカラムを削除する
    remove_column :notifications, :follower_id

    # 他の変更があれば、ここに記述する
  end
end
