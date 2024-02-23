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
  
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
def destroy
  @notification = Notification.find(params[:id])
  @notification.destroy
  redirect_to root_path, notice: '通知が削除されました。'
end
  
  def delete_all
    current_user.notifications.destroy_all
    redirect_to notifications_url, notice: '全ての通知が削除されました。'
  end
  private
  
  def set_notification
    @notification = Notification.find(params[:id])
  end
  def notification_params
    params.require(:notification).permit(:memo)
  end
end