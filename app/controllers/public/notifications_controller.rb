class Public::NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]

def index
  # 未読の通知を取得して閲覧状態を更新する
  @notifications = current_user.notifications.where(viewed: false)
  @notifications.each do |notification|
    notification.update(viewed: true)
  end

  # フォローの通知のみを表示する
  @follow_notifications = current_user.passive_notifications.follow_notifications.where.not(sender_id: current_user.id).page(params[:page]).per(20)
  @follow_notifications.where(checked: false).each do |notification|
    notification.update(checked: true)
  end
end


  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to public_notifications_path
    else
      render :new
    end
  end
  
  def destroy
    @notification.destroy
    redirect_to root_path
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
