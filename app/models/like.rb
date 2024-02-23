class Like < ApplicationRecord
  after_create :create_like_notification

  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  private

  def create_like_notification
    # いいねを行ったユーザーといいねを受けた投稿のユーザーを取得
    liker = self.user
    post_user = self.post.user

    # いいねを行ったユーザーといいねを受けた投稿のユーザーが異なる場合にのみ通知を作成
    if liker != post_user
      # 通知を作成
      Notification.create(
        visitor_id: liker.id,
        visited_id: post_user.id,
        post_id: self.post.id,
        action: 'like'
      )
    end
  end
end
