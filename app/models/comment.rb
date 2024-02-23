class Comment < ApplicationRecord
  after_create :create_comment_notification
  belongs_to :user  #Comment.userでコメントの所有者を取得
  belongs_to :post  #Comment.postでそのコメントがされた投稿を取得
  belongs_to :parent_comment, class_name: "Comment", optional: true
  has_many :replies, dependent: :destroy 
  

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

