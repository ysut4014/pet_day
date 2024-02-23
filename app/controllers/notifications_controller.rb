class NotificationsController < ApplicationController
  # 他のアクションと同様に、delete_allアクションを定義します。
  def delete_all
    current_user.notifications.destroy_all
    redirect_to root_path, notice: '全ての通知が削除されました。'
  end
end
