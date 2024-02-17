# db/migrate/[timestamp]_add_public_email_to_users.rb
class AddPublicEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :public_email, :boolean, default: false
  end
end
