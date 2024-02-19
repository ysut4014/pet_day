class AddViewedToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :viewed, :boolean, default: false
  end
end
