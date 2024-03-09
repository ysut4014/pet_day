class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) } # 通知を作成日時の降順で取得するデフォルトの並び順を指定します

  # 通知は投稿やコメントに関連付けられることがありますが、必須ではないためoptional: trueを指定します
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  # 通知に関連付けられるユーザー（visitor）と対象ユーザー（visited）を関連付けます
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  # 通知のメッセージを生成するメソッドです
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
