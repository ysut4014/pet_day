class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      # 他のカラムの定義も追加する場合はここに記述
      t.timestamps
    end
  end
end
