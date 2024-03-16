class CreateCommentReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_replies do |t|
      t.bigint :user_id, null: false
      t.bigint :comment_id, null: false

      t.timestamps
    end

  end
end
