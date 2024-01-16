class CreateCommentReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_replies do |t|
      t.integer :user_id, null: false
      t.integer :comment_id, null: false

      t.timestamps
    end

  end
end
