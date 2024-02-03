class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
  has_many :followees, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :followees, source: :followee

  def following?(user)
    following.include?(user)
  end
end