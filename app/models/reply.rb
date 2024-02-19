class Reply < ApplicationRecord
  after_create :send_notification
  belongs_to :user
  belongs_to :comment
  private

  def send_notification
    # 元のコメントを投稿したユーザーに通知を送信する例
    original_comment_user = Comment.find(self.comment_id).user

    Notification.create(
      visitor_id: self.user_id,
      visited_id: original_comment_user.id,
      comment_id: self.comment_id,
      action: "replied",
      is_checked: false
    )
  end
end
