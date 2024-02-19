# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }
  validates_inclusion_of :is_active, in: [true, false]
  
  has_many :posts
  has_many :likes, dependent: :destroy  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followed_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :follower
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  def active?
    is_active
  end
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationship = relationships.find_by(followed_id: user_id)
    relationship&.destroy
  end

  def following?(user)
    followings.include?(user)
  end
  def followed_posts
    Post.where(user_id: follower_ids)
  end
  
end
