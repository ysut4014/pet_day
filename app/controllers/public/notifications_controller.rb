class Public::NotificationsController < ApplicationController
def index
  @notifications = current_user.notifications.where(viewed: false)
  
  # 未読の通知を閲覧したときに閲覧状態を更新する
  @notifications.each do |notification|
    notification.update(viewed: true)
  end
end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to public_notifications_path, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:memo)
  end
end
