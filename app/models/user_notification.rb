class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :sender
  belongs_to :post
end
