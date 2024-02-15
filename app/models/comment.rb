class Comment < ApplicationRecord
  belongs_to :user  #Comment.userでコメントの所有者を取得
  belongs_to :post  #Comment.postでそのコメントがされた投稿を取得
  belongs_to :parent_comment, class_name: "Comment", optional: true
  has_many :replies, dependent: :destroy 
end
