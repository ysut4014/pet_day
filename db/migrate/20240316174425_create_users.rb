class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text :introduction, default: ""
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :profile_image_path, default: ""
      t.string :header_image_path, default: ""
      t.boolean :is_active, default: true, null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.boolean :public_email, default: false
      t.string :profile_image
      t.string :default_profile_image

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end