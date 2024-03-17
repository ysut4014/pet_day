class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.bigint :visitor_id, null: false
      t.bigint :visited_id, null: false
      t.bigint :comment_id
      t.bigint :like_id
      t.string :action, null: false
      t.boolean :is_checked, default: false, null: false
      t.text :memo
      t.bigint :post_id
      t.boolean :checked

      t.timestamps null: false
    end
  end
end
