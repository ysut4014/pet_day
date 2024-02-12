class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy  #Post.commentsで、投稿が所有するコメントw取得できる。
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end