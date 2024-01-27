class AddDefaultToIntroductionInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :introduction, :text, default: '', null: true
  end

  def down
    change_column :users, :introduction, :text, default: '', null: false
  end
end
