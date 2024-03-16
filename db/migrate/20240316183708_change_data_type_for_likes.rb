class ChangeDataTypeForLikes < ActiveRecord::Migration[6.1]
  def change
    change_column :likes, :user_id, :bigint
    change_column :likes, :post_id, :bigint
  end
end
