class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :notification_type
      t.boolean :read

      t.timestamps
    end
  end
end
