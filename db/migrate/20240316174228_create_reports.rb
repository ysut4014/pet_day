class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.bigint :reporter_id
      t.bigint :reported_id
      t.text :reason
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.bigint :user_id, null: false
    end
  end
end