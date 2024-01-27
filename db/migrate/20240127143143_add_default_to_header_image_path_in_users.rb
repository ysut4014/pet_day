class AddDefaultToHeaderImagePathInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :header_image_path, :string, default: '', null: true
  end

  def down
    change_column :users, :header_image_path, :string, default: '', null: false
  end
end
