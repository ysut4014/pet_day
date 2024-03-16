class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.bigint :follower_id, null: false
      t.bigint :followee_id, null: false

      t.timestamps
    end

  end
end
