class AddForeignKeyToCommentReplies < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :comment_replies, :users, column: :user_id
    add_foreign_key :comment_replies, :comments, column: :comment_id
    
  end
end
