class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user! 

  # ユーザーをフォローするアクション
  def create
    current_user.follow(params[:user_id])
    
    if params[:relationship].present? && params[:relationship][:following_id].present?
      @user = User.find(params[:relationship][:following_id])
      current_user.follow!(@user)
      @user.create_notification_follow!(current_user)
    end
    
    redirect_to request.referer
  end
  
  # ユーザーのフォローを解除するアクション
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end

  # フォローしているユーザーの一覧を表示するアクション
  def followings
    @user = User.find(params[:user_id])
    @followings = @user.followings.distinct
  end

  # フォロワーの一覧を表示するアクション
  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.distinct
  end
  
  # すべてのユーザーの一覧を表示するアクション
  def show
    @users = User.all
  end  
end
