class AddForeignKeyToFollows < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :followee_id
  end
end
