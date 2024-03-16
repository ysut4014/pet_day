class ChangeUserDataTypeInLikes < ActiveRecord::Migration[6.1]
  def change
    change_column :likes, :user_id, :bigint
  end
end
