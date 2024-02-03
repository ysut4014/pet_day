class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end