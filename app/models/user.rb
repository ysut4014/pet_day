# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }
  validates_inclusion_of :is_active, in: [true, false]
  
  belongs_to :user
  
  has_many :posts
  has_many :likes, dependent: :destroy  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

def unfollow(user_id)
  relationship = relationships.find_by(followed_id: user_id)
  relationship&.destroy if relationship
end

  def following?(user)
    followings.include?(user)
  end
end
