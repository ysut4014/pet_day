class AddDefaultToProfileImagePathInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :profile_image_path, :string, default: '', null: true
  end

  def down
    change_column :users, :profile_image_path, :string, default: '', null: false
  end
end
