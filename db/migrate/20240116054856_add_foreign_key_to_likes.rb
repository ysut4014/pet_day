class AddForeignKeyToLikes < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :likes, :users
  end
end
