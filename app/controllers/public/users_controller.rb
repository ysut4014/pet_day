# app/controllers/public/users_controller.rb
class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end
  
  def index
    @user = current_user
    @posts = @user.posts
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end  
  def edit
    # 編集処理を実装する
  end  
  def update
    # updateアクションの処理
  end
 private
  def set_user
    @user = User.find(params[:id])
  end  
end
