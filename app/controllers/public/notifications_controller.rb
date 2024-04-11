class Public::NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]

  def index
    @follow_notifications = current_user.passive_notifications
    if @follow_notifications.present?
      @follow_notifications = @follow_notifications.follow_notifications.where.not(sender_id: current_user.id).page(params[:page]).per(20)
      mark_checked_notifications(@follow_notifications.where(checked: false))
    else
      @no_notifications_message = "通知はありません。"
    end
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to notifications_path
    else
      render :new
    end
  end
  
  def destroy
    @notification.destroy
    redirect_to root_path
  end
  
  def destroy_all
    current_user.notifications.destroy_all
    redirect_to root_path, notice: '全ての通知が削除されました。'
  end

  private
  
  def set_notification
    @notification = Notification.find(params[:id])
  end
  
  def notification_params
    params.require(:notification).permit(:memo)
  end

  def mark_checked_notifications(notifications)
    notifications.each { |notification| notification.update(checked: true) }
  end
end
