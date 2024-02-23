class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーをリダイレクトする

  # フォローするとき
def create
  current_user.follow(params[:user_id])
  
  if params[:relationship].present? && params[:relationship][:following_id].present?
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    @user.create_notification_follow!(current_user)
  else
    # パラメータが正しくない場合の処理を記述する
  end
  
  redirect_to request.referer
end

  
  

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  # フォロー一覧
def followings
  @user = User.find(params[:user_id])
  @followings = @user.followings.distinct
end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.distinct
  end
  def show
    # ここでusersを定義する
    @users = User.all
  end  
  
  
end
