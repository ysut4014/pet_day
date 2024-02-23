# app/controllers/public/users_controller.rb
class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = current_user
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def search
    @query = params[:query]
    @posts = Post.joins(:user).where("posts.title LIKE ? OR posts.content LIKE ? OR users.name LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%").paginate(page: params[:page], per_page: 10)
  end
  
 private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :public_email)
  end
end
