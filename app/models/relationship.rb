class Relationship < ApplicationRecord
  after_create :create_follow_notification
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  has_many :followees, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :followees, source: :followee

  def create_follow_notification
    followed_user = User.find(followed_id)
    followed_user.notifications.create(visitor_id: follower_id, action: 'follow', comment_id: nil)
  end
end
