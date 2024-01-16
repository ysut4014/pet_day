class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.text :posted_text, null: false
      t.text :reply, null: false

      t.timestamps
    end

  end
end
