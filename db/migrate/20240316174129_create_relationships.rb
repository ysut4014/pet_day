class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.bigint :follower_id
      t.bigint :followed_id
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false

      # follower_id が users テーブルの主キーを参照する外部キー制約を追加
      add_foreign_key :relationships, :users, column: :follower_id
      # followed_id が users テーブルの主キーを参照する外部キー制約を追加
      add_foreign_key :relationships, :users, column: :followed_id
    end
  end
end
