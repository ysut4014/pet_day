class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }
  validates_inclusion_of :is_active, in: [true, false]
  
  has_many :posts
  has_many :likes, dependent: :destroy  
  has_many :followees, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :followees, source: :followee

  def following?(user)
    following.include?(user)
  end
end