class Comment < ApplicationRecord
    after_create :send_notification
  belongs_to :user  #Comment.userでコメントの所有者を取得
  belongs_to :post  #Comment.postでそのコメントがされた投稿を取得
  belongs_to :parent_comment, class_name: "Comment", optional: true
  has_many :replies, dependent: :destroy 
  
  private

  def send_notification
    # コメントを投稿したユーザー以外のユーザーに通知を送信する例
    users_to_notify = User.where.not(id: self.user_id)
    
    users_to_notify.each do |user|
      Notification.create(
        visitor_id: self.user_id,
        visited_id: user.id,
        comment_id: self.id,
        action: "commented",
        is_checked: false
      )
    end
  end
end

