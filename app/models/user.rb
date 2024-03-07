# app/models/user.rb
class User < ApplicationRecord
  
  after_create :create_notification_for_followers

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates_inclusion_of :is_active, in: [true, false]
  attr_accessor :delete_posts
  belongs_to :user
  has_many :notifications, dependent: :destroy  
  has_many :notifications, foreign_key: :visited_id
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
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
   # アカウントを有効化するメソッド
  def activate_account
    update(is_active: true)
  end

  # アカウントを無効化するメソッド
  def deactivate_account
    update(is_active: false)
  end
    
  
# フォロー機能
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
  
# 通知機能

  def create_notification_for_followers
    followers.each do |follower|
      Notification.create(
        visitor_id: user.id,
        visited_id: follower.id,
        post_id: id,
        action: 'post'
      )
    end
  end


  def update_notifications_sender!(new_sender_id)
    notifications.update_all(visitor_id: new_sender_id)
  end  
end
