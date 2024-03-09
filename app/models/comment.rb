class Comment < ApplicationRecord
  after_create :create_comment_notification
  belongs_to :user  
  belongs_to :post 
  belongs_to :parent_comment, class_name: "Comment", optional: true
  #has_many :replies, dependent: :destroy 
  has_many :notifications, dependent: :destroy
  

  private

  def create_comment_notification
    Notification.create(
      visitor_id: user_id,
      visited_id: post.user_id,
      comment_id: id,
      action: "comment",
      is_checked: false
    )
  end
end

