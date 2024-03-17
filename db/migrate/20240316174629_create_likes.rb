class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps precision: 6, null: false
    end

    add_index :likes, [:user_id, :post_id], unique: true
  end
end
