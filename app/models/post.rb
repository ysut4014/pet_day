class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
    belongs_to :user
  has_many :likes, dependent: :destroy
end