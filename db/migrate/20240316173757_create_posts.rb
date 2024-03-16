class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.bigint :user_id, null: false
      t.boolean :viewed, default: false
      t.timestamps precision: 6, null: false
    end

    add_index :posts, :user_id
  end
end
