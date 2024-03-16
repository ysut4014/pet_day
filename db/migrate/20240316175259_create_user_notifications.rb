class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false
      t.string :notification_type
      t.boolean :read
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false

      t.index :post_id, name: "index_user_notifications_on_post_id"
      t.index :sender_id, name: "index_user_notifications_on_sender_id"
      t.index :user_id, name: "index_user_notifications_on_user_id"
    end
  end
end
