class ChangeReplyToNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :comments, :reply, true
  end
end
