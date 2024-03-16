
class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.bigint :user_id, null: false
      t.string :content
      t.text :posted_text, null: false
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.bigint :post_id, null: false

      t.index [:post_id], name: "index_comments_on_post_id"
    end
  end
end