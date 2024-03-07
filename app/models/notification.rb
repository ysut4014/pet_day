class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  def message
    case action
    when 'like'
      "#{visitor.name}さんがあなたの投稿にいいねしました"
    when 'comment'
      "#{visitor.name}さんがあなたの投稿にコメントしました"
    else
      "#{visitor.name}さんの新しい投稿があります"
    end
  end
end
