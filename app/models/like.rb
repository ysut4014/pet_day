class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post # おそらくあなたの関連付けに基づいてこれを調整してください
end