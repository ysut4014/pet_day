class AddDefaultProfileImageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :default_profile_image, :string
  end
end
