class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false

      # Add indexes for email and reset_password_token
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end