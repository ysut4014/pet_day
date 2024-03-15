class Report < ApplicationRecord
  belongs_to :user
  validates :reported_id, presence: true
  validates :reason, presence: true
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
end
